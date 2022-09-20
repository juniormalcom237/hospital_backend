/*
  Warnings:

  - You are about to drop the column `messagesMessageId` on the `User` table. All the data in the column will be lost.
  - You are about to drop the column `notificationNotificationID` on the `User` table. All the data in the column will be lost.

*/
-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Notification" (
    "NotificationID" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "recievers" INTEGER NOT NULL,
    "sender" INTEGER NOT NULL,
    "userUserId" INTEGER,
    CONSTRAINT "Notification_userUserId_fkey" FOREIGN KEY ("userUserId") REFERENCES "User" ("userId") ON DELETE SET NULL ON UPDATE CASCADE
);
INSERT INTO "new_Notification" ("NotificationID", "recievers", "sender") SELECT "NotificationID", "recievers", "sender" FROM "Notification";
DROP TABLE "Notification";
ALTER TABLE "new_Notification" RENAME TO "Notification";
CREATE TABLE "new_Messages" (
    "messageId" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "date" DATETIME NOT NULL,
    "recievers" INTEGER NOT NULL,
    "userUserId" INTEGER,
    CONSTRAINT "Messages_userUserId_fkey" FOREIGN KEY ("userUserId") REFERENCES "User" ("userId") ON DELETE SET NULL ON UPDATE CASCADE
);
INSERT INTO "new_Messages" ("date", "messageId", "recievers") SELECT "date", "messageId", "recievers" FROM "Messages";
DROP TABLE "Messages";
ALTER TABLE "new_Messages" RENAME TO "Messages";
CREATE TABLE "new_User" (
    "userId" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "surname" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "telephone" TEXT NOT NULL,
    "country" TEXT NOT NULL,
    "status" BOOLEAN NOT NULL
);
INSERT INTO "new_User" ("country", "email", "name", "password", "status", "surname", "telephone", "userId") SELECT "country", "email", "name", "password", "status", "surname", "telephone", "userId" FROM "User";
DROP TABLE "User";
ALTER TABLE "new_User" RENAME TO "User";
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
