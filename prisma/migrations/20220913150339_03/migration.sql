/*
  Warnings:

  - You are about to drop the column `deptId` on the `Doctor` table. All the data in the column will be lost.

*/
-- CreateTable
CREATE TABLE "Messages" (
    "messageId" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "date" DATETIME NOT NULL,
    "recievers" INTEGER NOT NULL
);

-- CreateTable
CREATE TABLE "Appointment" (
    "appointmentId" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "time" DATETIME NOT NULL,
    "Date" DATETIME NOT NULL,
    "status" BOOLEAN NOT NULL
);

-- CreateTable
CREATE TABLE "Files" (
    "fileID" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "type" TEXT NOT NULL,
    "extension" TEXT NOT NULL,
    "size" TEXT NOT NULL,
    "folderFolderId" INTEGER,
    CONSTRAINT "Files_folderFolderId_fkey" FOREIGN KEY ("folderFolderId") REFERENCES "Folder" ("folderId") ON DELETE SET NULL ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Folder" (
    "folderId" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "createdAt" DATETIME NOT NULL
);

-- CreateTable
CREATE TABLE "Symptoms" (
    "symID" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "medicalRecordMedicalRecordId" INTEGER,
    CONSTRAINT "Symptoms_medicalRecordMedicalRecordId_fkey" FOREIGN KEY ("medicalRecordMedicalRecordId") REFERENCES "MedicalRecord" ("medicalRecordId") ON DELETE SET NULL ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "MedicalRecord" (
    "medicalRecordId" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "visiteNotes" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "Prescription" (
    "prescriptionId" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "medicalRecordMedicalRecordId" INTEGER,
    CONSTRAINT "Prescription_medicalRecordMedicalRecordId_fkey" FOREIGN KEY ("medicalRecordMedicalRecordId") REFERENCES "MedicalRecord" ("medicalRecordId") ON DELETE SET NULL ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Medication" (
    "medicalRecordId" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "dosage" TEXT NOT NULL,
    "timeOfEating" TEXT NOT NULL,
    "route" TEXT NOT NULL,
    "frequency" TEXT NOT NULL,
    "duration" DATETIME NOT NULL,
    "dispense" TEXT NOT NULL,
    "firstInTake" TEXT NOT NULL,
    "Interval" TEXT NOT NULL,
    "comment" TEXT NOT NULL,
    "prescriptionPrescriptionId" INTEGER,
    CONSTRAINT "Medication_prescriptionPrescriptionId_fkey" FOREIGN KEY ("prescriptionPrescriptionId") REFERENCES "Prescription" ("prescriptionId") ON DELETE SET NULL ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Diagnosis" (
    "DiagnoseID" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "medicalRecordMedicalRecordId" INTEGER,
    CONSTRAINT "Diagnosis_medicalRecordMedicalRecordId_fkey" FOREIGN KEY ("medicalRecordMedicalRecordId") REFERENCES "MedicalRecord" ("medicalRecordId") ON DELETE SET NULL ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Pills" (
    "pills" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "amount" TEXT NOT NULL,
    "howLong" TEXT NOT NULL,
    "days" TEXT NOT NULL,
    "medicineFormMedicalRecordId" INTEGER,
    "medicineReminderMedicalRecordId" INTEGER,
    CONSTRAINT "Pills_medicineFormMedicalRecordId_fkey" FOREIGN KEY ("medicineFormMedicalRecordId") REFERENCES "MedicineForm" ("medicalRecordId") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "Pills_medicineReminderMedicalRecordId_fkey" FOREIGN KEY ("medicineReminderMedicalRecordId") REFERENCES "MedicineReminder" ("medicalRecordId") ON DELETE SET NULL ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "MedicineForm" (
    "medicalRecordId" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "icon" TEXT NOT NULL,
    "name" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "MedicineReminder" (
    "medicalRecordId" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "Time" DATETIME NOT NULL
);

-- CreateTable
CREATE TABLE "Notification" (
    "NotificationID" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "recievers" INTEGER NOT NULL,
    "sender" INTEGER NOT NULL
);

-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Doctor" (
    "doctorID" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "studies" TEXT NOT NULL,
    "practicing" TEXT NOT NULL,
    "departmentDeptId" INTEGER,
    "appointmentAppointmentId" INTEGER,
    CONSTRAINT "Doctor_departmentDeptId_fkey" FOREIGN KEY ("departmentDeptId") REFERENCES "Department" ("deptId") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "Doctor_appointmentAppointmentId_fkey" FOREIGN KEY ("appointmentAppointmentId") REFERENCES "Appointment" ("appointmentId") ON DELETE SET NULL ON UPDATE CASCADE
);
INSERT INTO "new_Doctor" ("departmentDeptId", "doctorID", "practicing", "studies") SELECT "departmentDeptId", "doctorID", "practicing", "studies" FROM "Doctor";
DROP TABLE "Doctor";
ALTER TABLE "new_Doctor" RENAME TO "Doctor";
CREATE TABLE "new_Patient" (
    "patientId" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "bloodGroup" TEXT NOT NULL,
    "userID" INTEGER NOT NULL,
    "appointmentAppointmentId" INTEGER,
    CONSTRAINT "Patient_userID_fkey" FOREIGN KEY ("userID") REFERENCES "User" ("userId") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "Patient_appointmentAppointmentId_fkey" FOREIGN KEY ("appointmentAppointmentId") REFERENCES "Appointment" ("appointmentId") ON DELETE SET NULL ON UPDATE CASCADE
);
INSERT INTO "new_Patient" ("bloodGroup", "patientId", "userID") SELECT "bloodGroup", "patientId", "userID" FROM "Patient";
DROP TABLE "Patient";
ALTER TABLE "new_Patient" RENAME TO "Patient";
CREATE TABLE "new_User" (
    "userId" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "surname" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "telephone" TEXT NOT NULL,
    "country" TEXT NOT NULL,
    "status" BOOLEAN NOT NULL,
    "messagesMessageId" INTEGER,
    "notificationNotificationID" INTEGER,
    CONSTRAINT "User_messagesMessageId_fkey" FOREIGN KEY ("messagesMessageId") REFERENCES "Messages" ("messageId") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "User_notificationNotificationID_fkey" FOREIGN KEY ("notificationNotificationID") REFERENCES "Notification" ("NotificationID") ON DELETE SET NULL ON UPDATE CASCADE
);
INSERT INTO "new_User" ("country", "email", "name", "password", "status", "surname", "telephone", "userId") SELECT "country", "email", "name", "password", "status", "surname", "telephone", "userId" FROM "User";
DROP TABLE "User";
ALTER TABLE "new_User" RENAME TO "User";
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
