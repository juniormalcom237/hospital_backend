/*
  Warnings:

  - You are about to drop the column `appointmentAppointmentId` on the `Patient` table. All the data in the column will be lost.
  - You are about to drop the column `appointmentAppointmentId` on the `Doctor` table. All the data in the column will be lost.

*/
-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Patient" (
    "patientId" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "bloodGroup" TEXT NOT NULL,
    "userID" INTEGER NOT NULL,
    CONSTRAINT "Patient_userID_fkey" FOREIGN KEY ("userID") REFERENCES "User" ("userId") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_Patient" ("bloodGroup", "patientId", "userID") SELECT "bloodGroup", "patientId", "userID" FROM "Patient";
DROP TABLE "Patient";
ALTER TABLE "new_Patient" RENAME TO "Patient";
CREATE TABLE "new_Appointment" (
    "appointmentId" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "time" DATETIME NOT NULL,
    "Date" DATETIME NOT NULL,
    "status" BOOLEAN NOT NULL,
    "patientPatientId" INTEGER,
    "doctorDoctorID" INTEGER,
    CONSTRAINT "Appointment_patientPatientId_fkey" FOREIGN KEY ("patientPatientId") REFERENCES "Patient" ("patientId") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "Appointment_doctorDoctorID_fkey" FOREIGN KEY ("doctorDoctorID") REFERENCES "Doctor" ("doctorID") ON DELETE SET NULL ON UPDATE CASCADE
);
INSERT INTO "new_Appointment" ("Date", "appointmentId", "name", "status", "time") SELECT "Date", "appointmentId", "name", "status", "time" FROM "Appointment";
DROP TABLE "Appointment";
ALTER TABLE "new_Appointment" RENAME TO "Appointment";
CREATE TABLE "new_Doctor" (
    "doctorID" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "studies" TEXT NOT NULL,
    "practicing" TEXT NOT NULL,
    "departmentDeptId" INTEGER,
    CONSTRAINT "Doctor_departmentDeptId_fkey" FOREIGN KEY ("departmentDeptId") REFERENCES "Department" ("deptId") ON DELETE SET NULL ON UPDATE CASCADE
);
INSERT INTO "new_Doctor" ("departmentDeptId", "doctorID", "practicing", "studies") SELECT "departmentDeptId", "doctorID", "practicing", "studies" FROM "Doctor";
DROP TABLE "Doctor";
ALTER TABLE "new_Doctor" RENAME TO "Doctor";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
