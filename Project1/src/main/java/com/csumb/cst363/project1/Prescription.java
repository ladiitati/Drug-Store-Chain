package com.csumb.cst363.project1;

import java.sql.Date;

public class Prescription {
    int doctorID;
    int patientID;
    String drugName = "w";
    int quantity;
    int refills;
    Date date;
    //int prescriptionID;

    public int getPrescriptionID() {
        //return prescriptionID;
        return 0;
    }

    public void setPrescriptionID(int prescriptionID) {
        // this.prescriptionID = prescriptionID;
    }

    public Prescription() {

    }

    public Prescription(int doctorID, int patientID, String drugName,
                        int quantity, int refills, Date date) {
        this.doctorID = doctorID;
        this.patientID = patientID;
        this.drugName = drugName;
        this.quantity = quantity;
        this.refills = refills;
        this.date = date;
    }

    public Prescription(int doctorID, int patientID, String drugName,
                        int quantity, int refills, int prescriptionID) {
        this.doctorID = doctorID;
        this.patientID = patientID;
        this.drugName = drugName;
        this.quantity = quantity;
        this.refills = refills;
        //this.prescriptionID = prescriptionID;
    }

    public int getDoctorID() {
        return doctorID;
    }

    public void setDoctorID(int doctorSSN) {
        this.doctorID = doctorID;
    }

    public int getPatientID() {
        return patientID;
    }

    public void setPatientID(int patientID) {
        this.patientID = patientID;
    }

    public String getDrugName() {
        return drugName;
    }

    public void setDrugName(String drugName) {
        this.drugName = drugName;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public int getRefills() {
        return refills;
    }

    public void setRefills(int refills) {
        this.refills = refills;
    }

    public Date getDate() {
        return date;
    }
}
