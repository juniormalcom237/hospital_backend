-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_MedicineReminder" (
    "medicalRecordId" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "Time" DATETIME NOT NULL,
    "userUserId" INTEGER,
    CONSTRAINT "MedicineReminder_userUserId_fkey" FOREIGN KEY ("userUserId") REFERENCES "User" ("userId") ON DELETE SET NULL ON UPDATE CASCADE
);
INSERT INTO "new_MedicineReminder" ("Time", "medicalRecordId") SELECT "Time", "medicalRecordId" FROM "MedicineReminder";
DROP TABLE "MedicineReminder";
ALTER TABLE "new_MedicineReminder" RENAME TO "MedicineReminder";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
