package com.csumb.cst363.project1;

import java.sql.Date;

public class FdaReportResult {
    int prescriptionId;
    int drugId;
    int doctorId;
    int refills;
    int quantity;
    int patientId;
    Date date;
    String drugName;
    String doctorName;

    public FdaReportResult(int drugId, int refills, Date date, String drugName, String doctorName, int doctorId, int quantity, int patientId, int prescriptionId) {
        this.drugId = drugId;
        this.refills = refills;
        this.date = date;
        this.drugName = drugName;
        this.doctorName = doctorName;
        this.doctorId = doctorId;
        this.quantity = quantity;
        this.patientId = patientId;
        this.prescriptionId = prescriptionId;
    }

    public int getPatientId() {
        return patientId;
    }

    public int getQuantity() {
        return quantity;
    }

    public int getDrugId() {
        return this.drugId;
    }

    public int getDoctorId() {
        return this.doctorId;
    }

    public int getRefills() {
        return this.refills;
    }

    public Date getDate() {
        return this.date;
    }

    public String getDrugName() {
        return drugName;
    }

    public String getDoctorName() {
        return doctorName;
    }
}
