package com.csumb.cst363.project1.controllers;

import java.util.ArrayList;
import java.util.List;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.csumb.cst363.project1.PharmacyReport;
import com.csumb.cst363.project1.Prescription;

@Controller
public class Application
{
   Prescription prescription = new Prescription();
   @Autowired
   JdbcTemplate jdbcTemplate;
   
   @InitBinder
   public void bindingPreparation(WebDataBinder binder) {
     DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
     CustomDateEditor orderDateEditor = new CustomDateEditor(dateFormat, true);
     binder.registerCustomEditor(Date.class, orderDateEditor);
   }
   
   public Application() {
      
   }
   
   @GetMapping("/project1")
   public String project1(Model model) {
      return "project1";
   }
   
   @RequestMapping(value = "/project1", params = "createPrescription", method = RequestMethod.POST)
   public String createPrescription(@Validated Prescription prescription, 
         BindingResult result, Model model) {  
      
      try {
         Connection conn = jdbcTemplate.getDataSource().getConnection();
         
         List<String> drugs = jdbcTemplate.query(
            "select distinct trade_name from Drug",
            new Object[] { } ,
            (rs, rowNum) -> new String(rs.getString("trade_name")));
         model.addAttribute("drugs", drugs);
         
         List<String> doctors = jdbcTemplate.query(
               "select distinct name from Doctor",
               new Object[] { } ,
               (rs, rowNum) -> new String(rs.getString("name")));
            model.addAttribute("doctors", doctors);
            
         List<String> pharmacies = jdbcTemplate.query(
               "select distinct name from Pharmacy",
               new Object[] { } ,
               (rs, rowNum) -> new String(rs.getString("name")));
            model.addAttribute("pharmacies", pharmacies);
            
            conn.close();
            
      } catch (SQLException e) {
         e.printStackTrace();
      }
      return "prescription";
   }
   
   @RequestMapping(value = "/project1", params = "fillPrescription", method = RequestMethod.POST)
   public String fillPrescription(@Validated Prescription prescription, 
         BindingResult result, Model model) {     
      return "prescriptionrequest";
   }
   
   @RequestMapping(value = "/project1", params = "pharmacyReport", method = RequestMethod.POST)
   public String pharmacyReport(@Validated Prescription prescription, 
         BindingResult result, Model model) {
      
      
      try {
         Connection conn = jdbcTemplate.getDataSource().getConnection();
      
         List<String> pharmacies = jdbcTemplate.query(
            "select distinct name from Pharmacy",
            new Object[] { } ,
            (rs, rowNum) -> new String(rs.getString("name")));
         model.addAttribute("pharmacies", pharmacies);
         
         conn.close();

      } catch (SQLException e) {
         e.printStackTrace();
      }
      
      return "pharmacyrequest";
   }
   
   @RequestMapping(value = "/project1", params = "FDAReport", method = RequestMethod.POST)
   public String FDAReport(@Validated Prescription prescription, 
         BindingResult result, Model model) {     
      return "fdarequest";
   }
   
   @RequestMapping(value = "/prescriptionform", params = "cancel", method = RequestMethod.POST)
   public String prescriptionDisplayCancel(Model model) {
      return "project1";
   }
   
   @RequestMapping(value = "/prescriptionform", params = "ok", method = RequestMethod.POST)
   public String prescriptionDisplayOK(@Validated Prescription prescription, 
         @RequestParam("pharmacy") String pharmacy, @RequestParam("drug") String drug,
         @RequestParam("doctor") String doctor, BindingResult result, Model model) {
      
      int prescription_ID = 0;
      int pharmacy_id = 0;
      int drug_id = 0;
      int doctor_id = 0;
      
      try {
         
         //get drugID from name
         Connection conn = jdbcTemplate.getDataSource().getConnection();
         
         PreparedStatement pstmt = conn.prepareStatement(
               "select pharmacy_id from Pharmacy where name = ?");
         pstmt.setString(1, pharmacy);
         ResultSet rs = pstmt.executeQuery();
         
         if(rs.next())
         {
            pharmacy_id = rs.getInt(1);
           // model.addAttribute("pharmacy_id", pharmacy_id);
         }
         
         //get Pharmacy ID from name
         pstmt = conn.prepareStatement(
               "select drug_id from Drug where trade_name = ?");
         pstmt.setString(1, drug);
         rs = pstmt.executeQuery();
         
         if(rs.next())
         {
            drug_id = rs.getInt(1);
           // model.addAttribute("pharmacy_id", pharmacy_id);
         }
         
         //get DoctorSSN using doctor name
         pstmt = conn.prepareStatement(
               "select doctor_SSN from Doctor where name = ?");
         pstmt.setString(1, doctor);
         rs = pstmt.executeQuery();
         
         if(rs.next())
         {
            doctor_id = rs.getInt(1);
            //model.addAttribute("pharmacy_id", pharmacy_id);
         }
         
         //Connection conn = jdbcTemplate.getDataSource().getConnection();
         //PreparedStatement 
         pstmt = conn.prepareStatement(
               "insert into prescription (doctor_ssn, patient_ssn, drug_ID, quantity, refills_auth, "
               + "date, dosage, pharmacy_id) "
               + "values (?,?,?,?,?,?,?,?)");
         pstmt.setString(1, Integer.toString(doctor_id));
         pstmt.setString(2, Integer.toString(prescription.getPatientID()));
         pstmt.setString(3, Integer.toString(drug_id));
         pstmt.setString(4, Integer.toString(prescription.getQuantity()));
         pstmt.setString(5, Integer.toString(prescription.getRefills()));
         pstmt.setString(6, prescription.getDate()); //use todays date
         pstmt.setString(7, Integer.toString(prescription.getDosage()));
         pstmt.setString(8, Integer.toString(pharmacy_id));
         int rc = pstmt.executeUpdate();
         
         ResultSet index = pstmt.executeQuery("SELECT LAST_INSERT_ID()");

         if(index.next())
         {
            prescription_ID = index.getInt(1);
         }
         
         model.addAttribute("prescription_ID", Integer.toString(prescription_ID));
         
      } catch (SQLException e) {
         e.printStackTrace();
      }
      return "prescriptionlist";
   }
   
   @PostMapping("/prescriptionrequest")
   public String processForm(@RequestParam("patientID") String patientID, 
         @RequestParam("prescriptionID") String prescriptionID, 
         Model model) {
      
      int price = 0;
      
      try {
         Connection conn = jdbcTemplate.getDataSource().getConnection();
         PreparedStatement pstmt = conn.prepareStatement(
               "select pd.price " +
               "from Pharmacy_drug pd " +
               "where drug_id = " +
               "(select drug_id " +
               "from prescription " +
               "where patient_ssn = ? " +
               "and prescription_id = ?) " +
               "and pharmacy_id =  " +
               "(select pharmacy_id " +
               "from patient  " +
               "where patient_ssn = ?) ");
         
         pstmt.setString(1, patientID);
         pstmt.setString(2, prescriptionID);
         pstmt.setString(3, patientID);
         ResultSet rs = pstmt.executeQuery();
      
         if (rs.next())
         {
            price = rs.getInt(1);
            model.addAttribute("price", price);
            model.addAttribute("prescriptionID", prescriptionID);
            model.addAttribute("patientID", patientID);
            
            System.out.println("Patient: " + patientID +
               ", PrescriptionID: " + prescriptionID + 
               ", Price: " + price);
         }
      
      } catch (SQLException e) {
         e.printStackTrace();
      }
      
      model.addAttribute("prescription", prescription);
      return "prescriptionfill";
   }
   
   @RequestMapping(value = "/prescriptionfill", params = "ok", method = RequestMethod.POST)
   public String prescriptionRequestOK(@RequestParam("patientID") String patientID,
         @RequestParam("prescriptionID") String prescriptionID, Model model) {
      
      
      return "prescriptionrequest";
   }
   
   @RequestMapping(value = "/prescriptionfill", params = "cancel", method = RequestMethod.POST)
   public String prescriptionRequestCancel(Model model) {     
      return "project1";
   }
   
   @RequestMapping(value = "/pharmacyrequest", params = "ok", method = RequestMethod.POST)
   public String pharmacyRequestOK(@RequestParam("pharmacy") String pharmacy, 
         @RequestParam("date") Date date, Model model) {
      
      
      try {
         Connection conn = jdbcTemplate.getDataSource().getConnection();
      
         PreparedStatement pstmt = conn.prepareStatement(
               "select pharmacy_id from Pharmacy where name = ?");
         pstmt.setString(1, pharmacy);
         ResultSet rs = pstmt.executeQuery();
         
         int pharmacy_id = 0;
         
         if(rs.next())
         {
            pharmacy_id = rs.getInt(1);
            model.addAttribute("pharmacy_id", pharmacy_id);
         }
         
         pstmt = conn.prepareStatement(
            "select trade_name, sum(pr.quantity) as quantity " +
            "from pharmacy_drug dp " +
            "join prescription pr on dp.pharmacy_id = pr.pharmacy_id " +
            "join drug dr on pr.drug_id = dr.drug_id " +
            "where date > ? " +
            "and pr.pharmacy_id = ? " +
            "group by dr.trade_name");
               
         pstmt.setDate(1, date);
         pstmt.setInt(2, pharmacy_id);
         rs = pstmt.executeQuery();
         
         ArrayList<PharmacyReport> report = new ArrayList<PharmacyReport>();
         
         while (rs.next())
         {
            report.add(new PharmacyReport(rs.getString("trade_name"), rs.getInt("quantity")));
         }

         model.addAttribute("report", report);
        
         conn.close();
         
      } catch (SQLException e) {
         e.printStackTrace();
      }
     
      model.addAttribute("date", date);
      return "pharmacyreport";
   }
  
   @RequestMapping(value = "/pharmacyrequest", params = "cancel", method = RequestMethod.POST)
   public String pharmacyRequestCancel(Model model) {
      return "project1";
   }
   
   @RequestMapping(value = "/pharmacyreport", params = "ok", method = RequestMethod.POST)
   public String pharmacyReporttOK(Model model) {
      model.addAttribute("pharmacy_id", 0);
      model.addAttribute("date", "");
      return "project1";
   }

}
