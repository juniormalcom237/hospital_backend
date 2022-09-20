-- CreateTable
CREATE TABLE "User" (
    "userId" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "surname" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "telephone" TEXT NOT NULL,
    "country" TEXT NOT NULL,
    "status" BOOLEAN NOT NULL
);

-- CreateTable
CREATE TABLE "Patient" (
    "patientId" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "bloodGroup" TEXT NOT NULL,
    "userID" INTEGER NOT NULL,
    CONSTRAINT "Patient_userID_fkey" FOREIGN KEY ("userID") REFERENCES "User" ("userId") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Doctor" (
    "doctorID" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "studies" TEXT NOT NULL,
    "practicing" TEXT NOT NULL,
    "deptId" INTEGER NOT NULL,
    "departmentDeptId" INTEGER,
    CONSTRAINT "Doctor_departmentDeptId_fkey" FOREIGN KEY ("departmentDeptId") REFERENCES "Department" ("deptId") ON DELETE SET NULL ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Department" (
    "deptId" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "deptName" TEXT NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");
