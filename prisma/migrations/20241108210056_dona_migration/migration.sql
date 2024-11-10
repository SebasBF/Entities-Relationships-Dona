-- CreateTable
CREATE TABLE "users" (
    "id" SERIAL NOT NULL,
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "recoveryToken" TEXT,

    CONSTRAINT "users_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "persons" (
    "id" SERIAL NOT NULL,
    "identificationTypeId" INTEGER NOT NULL,
    "roleId" INTEGER NOT NULL,
    "name" TEXT NOT NULL,
    "lastName" TEXT NOT NULL,
    "dateOfBirth" TIMESTAMP(3) NOT NULL,
    "gender" TEXT NOT NULL,
    "phoneNumber" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "address" TEXT NOT NULL,
    "coordinate" JSONB NOT NULL,
    "bloodType" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "userId" INTEGER NOT NULL,
    "donorInfoId" INTEGER,

    CONSTRAINT "persons_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "donorInfos" (
    "id" SERIAL NOT NULL,
    "lastDonation" TIMESTAMP(3) NOT NULL,
    "hasTattoo" BOOLEAN NOT NULL,
    "recentIllness" BOOLEAN NOT NULL,
    "travelHistory" TEXT NOT NULL,
    "medication" TEXT NOT NULL,
    "surgery" BOOLEAN NOT NULL,
    "pregnancy" BOOLEAN NOT NULL,
    "weight" DECIMAL(65,30) NOT NULL DEFAULT 4.2,
    "height" DECIMAL(65,30) NOT NULL DEFAULT 2.2,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "donationId" INTEGER NOT NULL,
    "personId" INTEGER NOT NULL,

    CONSTRAINT "donorInfos_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "institutions" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "address" TEXT NOT NULL,
    "coordinate" JSONB NOT NULL,
    "phone" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "activeHours" TIMESTAMP(3) NOT NULL,
    "bloodStorage" INTEGER NOT NULL,

    CONSTRAINT "institutions_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "status" (
    "id" SERIAL NOT NULL,
    "status" TEXT NOT NULL,

    CONSTRAINT "status_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "roles" (
    "id" SERIAL NOT NULL,
    "role" TEXT NOT NULL,
    "description" TEXT NOT NULL,

    CONSTRAINT "roles_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "bloodRequests" (
    "id" SERIAL NOT NULL,
    "centerDonationId" INTEGER NOT NULL,
    "identificationTypeId" INTEGER NOT NULL,
    "role" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "lastName" TEXT NOT NULL,
    "dateOfBirth" TIMESTAMP(3) NOT NULL,
    "gender" TEXT NOT NULL,
    "bloodType" TEXT NOT NULL,
    "phoneNumber" TEXT NOT NULL,
    "amountNeeded" INTEGER NOT NULL,
    "address" TEXT NOT NULL,
    "coordinate" JSONB NOT NULL,
    "email" TEXT NOT NULL,
    "issueDate" TIMESTAMP(3) NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "institutionId" INTEGER NOT NULL,
    "urgencyId" INTEGER NOT NULL,
    "personId" INTEGER NOT NULL,

    CONSTRAINT "bloodRequests_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "donations" (
    "id" SERIAL NOT NULL,
    "donorId" INTEGER NOT NULL,
    "amountDonated" INTEGER NOT NULL,
    "centerDonationId" INTEGER NOT NULL,
    "statusDonation" TEXT NOT NULL,
    "request" TEXT NOT NULL,
    "dateOfDonation" TIMESTAMP(3) NOT NULL,
    "institutionId" INTEGER NOT NULL,
    "statusId" INTEGER NOT NULL,
    "bloodRequestId" INTEGER NOT NULL,

    CONSTRAINT "donations_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "chats" (
    "id" SERIAL NOT NULL,
    "issueDate" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "chats_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "chatMessages" (
    "id" SERIAL NOT NULL,
    "chatContent" TEXT NOT NULL,
    "dateOfCreation" TIMESTAMP(3) NOT NULL,
    "chatId" INTEGER NOT NULL,

    CONSTRAINT "chatMessages_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "urgencies" (
    "id" SERIAL NOT NULL,
    "priority" INTEGER NOT NULL,

    CONSTRAINT "urgencies_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "identificationTypes" (
    "id" SERIAL NOT NULL,
    "Identification" TEXT NOT NULL,

    CONSTRAINT "identificationTypes_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "_ChatMessagesToPerson" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "users_email_key" ON "users"("email");

-- CreateIndex
CREATE UNIQUE INDEX "persons_identificationTypeId_key" ON "persons"("identificationTypeId");

-- CreateIndex
CREATE UNIQUE INDEX "persons_email_key" ON "persons"("email");

-- CreateIndex
CREATE UNIQUE INDEX "persons_userId_key" ON "persons"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "donorInfos_personId_key" ON "donorInfos"("personId");

-- CreateIndex
CREATE UNIQUE INDEX "bloodRequests_identificationTypeId_key" ON "bloodRequests"("identificationTypeId");

-- CreateIndex
CREATE UNIQUE INDEX "bloodRequests_email_key" ON "bloodRequests"("email");

-- CreateIndex
CREATE UNIQUE INDEX "donations_statusDonation_key" ON "donations"("statusDonation");

-- CreateIndex
CREATE UNIQUE INDEX "donations_statusId_key" ON "donations"("statusId");

-- CreateIndex
CREATE UNIQUE INDEX "_ChatMessagesToPerson_AB_unique" ON "_ChatMessagesToPerson"("A", "B");

-- CreateIndex
CREATE INDEX "_ChatMessagesToPerson_B_index" ON "_ChatMessagesToPerson"("B");

-- AddForeignKey
ALTER TABLE "persons" ADD CONSTRAINT "persons_identificationTypeId_fkey" FOREIGN KEY ("identificationTypeId") REFERENCES "identificationTypes"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "persons" ADD CONSTRAINT "persons_roleId_fkey" FOREIGN KEY ("roleId") REFERENCES "roles"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "persons" ADD CONSTRAINT "persons_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "donorInfos" ADD CONSTRAINT "donorInfos_donationId_fkey" FOREIGN KEY ("donationId") REFERENCES "donations"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "donorInfos" ADD CONSTRAINT "donorInfos_personId_fkey" FOREIGN KEY ("personId") REFERENCES "persons"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "bloodRequests" ADD CONSTRAINT "bloodRequests_identificationTypeId_fkey" FOREIGN KEY ("identificationTypeId") REFERENCES "identificationTypes"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "bloodRequests" ADD CONSTRAINT "bloodRequests_institutionId_fkey" FOREIGN KEY ("institutionId") REFERENCES "institutions"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "bloodRequests" ADD CONSTRAINT "bloodRequests_urgencyId_fkey" FOREIGN KEY ("urgencyId") REFERENCES "urgencies"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "bloodRequests" ADD CONSTRAINT "bloodRequests_personId_fkey" FOREIGN KEY ("personId") REFERENCES "persons"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "donations" ADD CONSTRAINT "donations_institutionId_fkey" FOREIGN KEY ("institutionId") REFERENCES "institutions"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "donations" ADD CONSTRAINT "donations_statusId_fkey" FOREIGN KEY ("statusId") REFERENCES "status"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "donations" ADD CONSTRAINT "donations_bloodRequestId_fkey" FOREIGN KEY ("bloodRequestId") REFERENCES "bloodRequests"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "chatMessages" ADD CONSTRAINT "chatMessages_chatId_fkey" FOREIGN KEY ("chatId") REFERENCES "chats"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_ChatMessagesToPerson" ADD CONSTRAINT "_ChatMessagesToPerson_A_fkey" FOREIGN KEY ("A") REFERENCES "chatMessages"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_ChatMessagesToPerson" ADD CONSTRAINT "_ChatMessagesToPerson_B_fkey" FOREIGN KEY ("B") REFERENCES "persons"("id") ON DELETE CASCADE ON UPDATE CASCADE;
