-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Pills" (
    "pills" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "amount" TEXT NOT NULL,
    "howLong" TEXT NOT NULL,
    "days" TEXT NOT NULL,
    "medicineFormMedicalRecordId" INTEGER,
    "medicineReminderMedicalRecordId" INTEGER,
    "userUserId" INTEGER,
    CONSTRAINT "Pills_medicineFormMedicalRecordId_fkey" FOREIGN KEY ("medicineFormMedicalRecordId") REFERENCES "MedicineForm" ("medicalRecordId") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "Pills_medicineReminderMedicalRecordId_fkey" FOREIGN KEY ("medicineReminderMedicalRecordId") REFERENCES "MedicineReminder" ("medicalRecordId") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "Pills_userUserId_fkey" FOREIGN KEY ("userUserId") REFERENCES "User" ("userId") ON DELETE SET NULL ON UPDATE CASCADE
);
INSERT INTO "new_Pills" ("amount", "days", "howLong", "medicineFormMedicalRecordId", "medicineReminderMedicalRecordId", "name", "pills") SELECT "amount", "days", "howLong", "medicineFormMedicalRecordId", "medicineReminderMedicalRecordId", "name", "pills" FROM "Pills";
DROP TABLE "Pills";
ALTER TABLE "new_Pills" RENAME TO "Pills";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
