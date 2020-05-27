package com.csumb.cst363.project1;

import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

public class FdaReport {
    ArrayList<FdaReportRow> reportRows;
    List<FdaReportResult> rawReportData;

    public FdaReport() {}

    public FdaReport(List<FdaReportResult> reportData) {
        this.rawReportData = reportData;
        this.reportRows = this.buildReportRows();
    }

    public ArrayList<FdaReportRow> getReportRows() {
        return this.reportRows;
    }

    private ArrayList<FdaReportRow> buildReportRows() {
        ArrayList<FdaReportRow> reportRows = new ArrayList<>();
        ArrayList<Integer> seen = new ArrayList<>();

        for (int i = 0; i < this.rawReportData.size(); i++) {
            if (!seen.contains(rawReportData.get(i).getDoctorId())) {
                seen.add(rawReportData.get(i).getDoctorId());
                reportRows.add(new FdaReportRow(rawReportData.get(i).getDoctorName(), rawReportData.get(i).getDoctorId(), this.rawReportData));
            }
        }
        return reportRows;
    }
}

class FdaReportRow {
    int doctorId;
    String doctorName;
    ArrayList<DrugSummary> drugSummaries = new ArrayList<>();

    public FdaReportRow(String doctorName, int doctorId, List<FdaReportResult> reportData) {
        this.doctorId = doctorId;
        this.doctorName = doctorName;
        ArrayList<Prescription> prescriptions = this.getPrescriptions(reportData);

        for (Prescription prescription : prescriptions) {
            if (prescription.getDoctorID() == doctorId) {
                this.updatePrescriptions(prescription);
            }
        }
    }

    private ArrayList<Prescription> getPrescriptions(List<FdaReportResult> reportData) {
        ArrayList<Integer> seen = new ArrayList<>();
        ArrayList<Prescription> prescriptions = new ArrayList<>();

        for (FdaReportResult reportDatum : reportData) {
            if (!seen.contains(reportDatum.getDoctorId())) {
                seen.add(reportDatum.getDoctorId());

                int doctorId = reportDatum.getDoctorId();
                int patientId = reportDatum.getPatientId();
                String drugName = reportDatum.getDrugName();
                int quantity = reportDatum.getQuantity();
                int refills = reportDatum.getRefills();
                Date date = reportDatum.getDate();

                prescriptions.add(new Prescription(doctorId, patientId, drugName, quantity, refills, date));
            }
        }
        return prescriptions;
    }

    private void updatePrescriptions(Prescription prescription) {
        ArrayList<Prescription> prescriptions = new ArrayList<>();

        for (DrugSummary drugSummary : this.drugSummaries) {
            if (prescription.drugName.equals(drugSummary.getDrugGenericName())) {
                prescriptions = drugSummary.getPrescriptions();
                drugSummary.incrementQuantity(prescription.getQuantity());
                prescriptions.add(prescription);
                break;
            }
        }
        prescriptions.add(prescription);
        this.drugSummaries.add(new DrugSummary(prescription.getDrugName(), prescription.getQuantity(), prescriptions));
    }

    public int getDoctorId() {
        return doctorId;
    }

    public String getDoctorName() {
        return this.doctorName;
    }

    public ArrayList<DrugSummary> getDrugSummaries() {
        return this.drugSummaries;
    }
}


class DrugSummary {
    String drugGenericName;
    int quantityPrescribed;
    ArrayList<Prescription> prescriptions = new ArrayList<>();

    DrugSummary(String drugName, int drugQuantity, ArrayList<Prescription> prescriptions) {
        this.drugGenericName = drugName;
        this.quantityPrescribed = drugQuantity;
        this.prescriptions = prescriptions;
    }

    public ArrayList<Prescription> getPrescriptions() {
        return prescriptions;
    }

    public void incrementQuantity(int incrementBy) {
        this.quantityPrescribed += incrementBy;
    }

    public String getDrugGenericName() {
        return this.drugGenericName;
    }

    public int getQuantityPrescribed() {
        return this.quantityPrescribed;
    }
}
