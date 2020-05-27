package com.csumb.cst363.project1.controllers;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;

import com.csumb.cst363.project1.FdaReport;
import com.csumb.cst363.project1.FdaReportResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;
import com.csumb.cst363.project1.Prescription;

@Controller
public class Application {
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

        return "pharmacyrequest";
    }

    @RequestMapping(value = "/project1", params = "FDAReport", method = RequestMethod.POST)
    public String FDAReport(@Validated Prescription prescription,
                            BindingResult result, Model model) {
        return "fdareport";
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

        try {
            Connection conn = jdbcTemplate.getDataSource().getConnection();
            PreparedStatement pstmt = conn.prepareStatement(
                    "insert into prescription (doctor_ssn, patientID, drugName, quantity, refills) "
                            + "values (?,?,?,?,?)");
            pstmt.setString(1, Integer.toString(prescription.getDoctorID()));
            pstmt.setString(2, Integer.toString(prescription.getPatientID()));
            pstmt.setString(3, prescription.getDrugName());
            pstmt.setString(4, Integer.toString(prescription.getQuantity()));
            pstmt.setString(5, Integer.toString(prescription.getRefills()));
            int rc = pstmt.executeUpdate();

            List<Prescription> prescriptions = jdbcTemplate.query(
                    "select doctor_ssn, patientID, drugName, quantity, refills, date "
                            + " from prescription",
                    new Object[]{},
                    (rs, rowNum) -> new Prescription(rs.getInt("doctor_ssn"),
                            rs.getInt("patientID"),
                            rs.getString("drugName"),
                            rs.getInt("quantity"),
                            rs.getInt("refills"),
                            rs.getDate("date")));
            model.addAttribute("prescriptions", prescriptions);

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
    public String pharmacyRequestOK(@RequestParam("pharmacyID") String pharmacyID,
                                    @RequestParam("date") Date date, Model model) {
        return "pharmacyreport";
    }

    @RequestMapping(value = "/pharmacyrequest", params = "cancel", method = RequestMethod.POST)
    public String pharmacyRequestCancel(@RequestParam("pharmacyID") String pharmacyID,
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
        model.addAttribute("pharmacyID", 0);
        model.addAttribute("date", "");
        return "pharmacyrequest";
    }

    @RequestMapping(value = "/fetchReport", method = RequestMethod.GET)
    @ResponseBody
    public FdaReport fetchReport() {
        try {
            List<FdaReportResult> report = jdbcTemplate.query(
                    "SELECT p.drug_id, p.refills_auth, p.date, rx.generic_name, d.name, d.doctor_ssn, p.quantity, pa.patient_ssn,  p.prescription_id\n" +
                            "FROM Prescription p, Doctor d, Drug rx, Patient pa\n" +
                            "WHERE p.doctor_ssn = d.doctor_ssn AND rx.drug_id = p.drug_id;",
                    new Object[]{},
                    (rs, rowNum) -> new FdaReportResult(rs.getInt("drug_id"),
                            rs.getInt("refills_auth"),
                            rs.getDate("date"),
                            rs.getString("generic_name"),
                            rs.getString("name"),
                            rs.getInt("doctor_ssn"),
                            rs.getInt("quantity"),
                            rs.getInt("patient_ssn"),
                            rs.getInt("prescription_id")
                    ));
            return new FdaReport(report);
        } catch (Error e) {
            e.printStackTrace();
        }
        return new FdaReport();
    }

    @GetMapping("/fdareport")
    public String fdaReport(Model model) {

        model.addAttribute("fdaReport");
        return "fdaReport";
    }

}
