package com.csumb.cst363.project1.controllers;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
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
   
/*   @GetMapping("/prescriptionform")
   public String prescriptionForm(Model model) {
      model.addAttribute("prescription", new Prescription());
      return "prescription";
   }*/
   
   @RequestMapping(value = "/prescriptionform", params = "cancel", method = RequestMethod.POST)
   public String prescriptionDisplayCancel(@Validated Prescription prescription, 
         BindingResult result, Model model) {
      model.addAttribute("prescription", new Prescription());
      return "prescription";
   }
   
   @RequestMapping(value = "/prescriptionform", params = "ok", method = RequestMethod.POST)
   public String prescriptionDisplayOK(@Validated Prescription prescription, 
         BindingResult result, Model model) {
      
      int prescription_ID = 0;
      
      try {
         Connection conn = jdbcTemplate.getDataSource().getConnection();
         PreparedStatement pstmt = conn.prepareStatement(
               "insert into prescription (doctor_ssn, patient_ssn, drug_ID, quantity, refills_auth, "
               + "date, dosage, pharmacy_id) "
               + "values (?,?,?,?,?,?,?,?)");
         pstmt.setString(1, Integer.toString(prescription.getDoctorID()));
         pstmt.setString(2, Integer.toString(prescription.getPatientID()));
         pstmt.setString(3, Integer.toString(prescription.getDrugID()));
         pstmt.setString(4, Integer.toString(prescription.getQuantity()));
         pstmt.setString(5, Integer.toString(prescription.getRefills()));
         pstmt.setString(6, "2020-01-01"); //use todays date
         pstmt.setString(7, "50");
         pstmt.setString(8, "1");
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
   
/*   @GetMapping("/prescriptionlist")
   public String prescriptionList(Model model) {
      return "prescriptionlist";
   }*/
   
/*   @GetMapping("/prescriptionrequest")
   public String prescriptionRequest(Model model) {
      model.addAttribute("prescription", new Prescription());
      return "prescriptionrequest";
   }*/
   
   @PostMapping("/prescriptionrequest")
   public String processForm(@Validated Prescription prescription, 
         BindingResult result, Model model, @RequestParam("stuff") String stuff) {
      model.addAttribute("prescription", prescription);
      model.addAttribute("stuff", stuff);
      return "prescriptionfill";
   }
   
   @RequestMapping(value = "/prescriptionfill", params = "ok", method = RequestMethod.POST)
   public String prescriptionRequestOK(@Validated Prescription prescription, 
         BindingResult result, Model model) {
      
      return "prescriptionrequest";
   }
   
   @RequestMapping(value = "/prescriptionfill", params = "cancel", method = RequestMethod.POST)
   public String prescriptionRequestCancel(@Validated Prescription prescription, 
         BindingResult result, Model model) {     
      return "prescriptionrequest";
   }
   
/*   // Pharmacy request stuff
   @GetMapping("/pharmacyrequest")
   public String pharmacyRequest(Model model) {
      
      return "pharmacyreport";
   }*/ 
   
   @RequestMapping(value = "/pharmacyrequest", params = "ok", method = RequestMethod.POST)
   public String pharmacyRequestOK(@RequestParam("pharmacy") String pharmacy, 
         @RequestParam("date") Date date, Model model) {
      
      
      try {
         Connection conn = jdbcTemplate.getDataSource().getConnection();
      
         PreparedStatement pstmt = conn.prepareStatement(
               "select pharmacy_id from Pharmacy where name = ?");
         pstmt.setString(1, pharmacy);
         ResultSet rs = pstmt.executeQuery();
         
         if(rs.next())
         {
            model.addAttribute("pharmacy_id", rs.getInt(1));
         }
         
         pstmt = conn.prepareStatement(
            "select dr.trade_name, sum(pr.quantity) as quantity " +
            "from pharmacy_drug dp " +
            "join prescription pr on dp.pharmacy_id = pr.pharmacy_id " +
            "join drug dr on pr.drug_id = dr.drug_id " +
            "where date > ? " +
            "and pr.pharmacy_id = ? " +
            "group by dr.trade_name");
         
         pstmt.setDate(1, date.valueOf("1998-1-17"));
         pstmt.setString(2, pharmacy);
         
         rs = pstmt.executeQuery();
         
         
         if (rs.next())
         {
            System.out.println("Printing result...");
            System.out.println(rs.getString("trade_name"));
            System.out.println(rs.getInt("quantity"));    
         }
         else
         {
            System.out.println("nada...");
         }
         
      } catch (SQLException e) {
         e.printStackTrace();
      }
     
      model.addAttribute("date", date);
      
      return "pharmacyreport";
   }
  
   @RequestMapping(value = "/pharmacyrequest", params = "cancel", method = RequestMethod.POST)
   public String pharmacyRequestCancel(@RequestParam("pharmacy_id") String pharmacy_id, 
         @RequestParam("date") Date date, Model model) {
      return "pharmacyrequest";
   }
   
/*   // Pharmacy report stuff
   @GetMapping("/pharmacyreport")
   public String pharmacyReport(Model model) {
      return "pharmacyreport";
   }*/
   
   @RequestMapping(value = "/pharmacyreport", params = "ok", method = RequestMethod.POST)
   public String pharmacyReporttOK(Model model) {
      model.addAttribute("pharmacy_id", 0);
      model.addAttribute("date", "");
      return "pharmacyrequest";
   }

}
