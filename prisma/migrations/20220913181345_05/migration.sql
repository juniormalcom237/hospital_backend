-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Doctor" (
    "doctorID" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "studies" TEXT NOT NULL,
    "practicing" TEXT NOT NULL,
    "departmentDeptId" INTEGER,
    "userUserId" INTEGER,
    CONSTRAINT "Doctor_departmentDeptId_fkey" FOREIGN KEY ("departmentDeptId") REFERENCES "Department" ("deptId") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "Doctor_userUserId_fkey" FOREIGN KEY ("userUserId") REFERENCES "User" ("userId") ON DELETE SET NULL ON UPDATE CASCADE
);
INSERT INTO "new_Doctor" ("departmentDeptId", "doctorID", "practicing", "studies") SELECT "departmentDeptId", "doctorID", "practicing", "studies" FROM "Doctor";
DROP TABLE "Doctor";
ALTER TABLE "new_Doctor" RENAME TO "Doctor";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
