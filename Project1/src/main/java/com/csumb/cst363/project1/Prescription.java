package com.csumb.cst363.project1;

import java.sql.Date;

public class Prescription {
    int doctorID;
    int patientID;
    String drugName;
    int drugID;
    int dosage;
    int pharmacyID;
    int refills;
    String date;
    Date sqlDate;

    public Date getSqlDate() {
        return sqlDate;
    }

    public String getDrugName() {
        return drugName;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public int getDosage() {
        return dosage;
    }

    public void setDosage(int dosage) {
        this.dosage = dosage;
    }

    public int getPharmacyID() {
        return pharmacyID;
    }

    public void setPharmacyID(int pharmacyID) {
        this.pharmacyID = pharmacyID;
    }

    int quantity;

    public int getDrugID() {
        return drugID;
    }

    public void setDrugID(int drugID) {
        this.drugID = drugID;
    }


    public int getPrescriptionID() {
        //return prescriptionID;
        return 0;
    }

    public void setPrescriptionID(int prescriptionID) {
        // this.prescriptionID = prescriptionID;
    }

    public Prescription() {

    }

    public Prescription(int doctorID, int patientID,
                        int quantity, int refills) {
        this.doctorID = doctorID;
        this.patientID = patientID;
        this.quantity = quantity;
        this.refills = refills;
    }

    public Prescription(int doctorID, int patientID, String drugName,
                        int quantity, int refills, Date date) {
        this.doctorID = doctorID;
        this.patientID = patientID;
        this.quantity = quantity;
        this.refills = refills;
        this.sqlDate = date;
        this.drugName = drugName;
    }

    public Prescription(int doctorID, int patientID,
                        int quantity, int refills, int prescriptionID) {
        this.doctorID = doctorID;
        this.patientID = patientID;
        this.quantity = quantity;
        this.refills = refills;
        //this.prescriptionID = prescriptionID;
    }

    public int getDoctorID() {
        return doctorID;
    }

    public void setDoctorID(int doctorID) {
        this.doctorID = doctorID;
    }

    public int getPatientID() {
        return patientID;
    }

    public void setPatientID(int patientID) {
        this.patientID = patientID;
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
}
