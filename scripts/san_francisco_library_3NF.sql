CREATE DATABASE san_francisco_library_2NF;
USE san_francisco_library_2NF;

# 1NF

CREATE TABLE MAIN (
    PatronTypeCode INT,
    PatronTypeDefinition VARCHAR(255),
    TotalCheckouts INT,
    TotalRenewals INT,
    AgeRange VARCHAR(255),
    HomeLibraryCode VARCHAR(255),
    HomeLibraryDefinition VARCHAR(255),
    CirculationActiveMonth VARCHAR(255),
    CirculationActiveYear INT,
    NotificationPreferenceCode VARCHAR(255),
    NotificationCodeDefinition VARCHAR(255),
    ProvidedEmailAddress VARCHAR(255),
    WithinSanFranciscoCounty VARCHAR(255),
    YearPatronRegistered INT
);

LOAD DATA INFILE '/var/lib/mysql-files/data.csv'
INTO TABLE MAIN
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n' (
    @vPatronTypeCode,
    @vPatronTypeDefinition,
    @vTotalCheckouts,
    @vTotalRenewals,
    @vAgeRange,
    @vHomeLibraryCode,
    @vHomeLibraryDefinition,
    @vCirculationActiveMonth,
    @vCirculationActiveYear,
    @vNotificationPreferenceCode,
    @vNotificationCodeDefinition,
    @vProvidedEmailAddress,
    @vWithinSanFranciscoCounty,
    @vYearPatronRegistered
)
SET
PatronTypeCode = NULLIF(@vPatronTypeCode,''),
PatronTypeDefinition = NULLIF(@vPatronTypeDefinition,''),
TotalCheckouts = NULLIF(@vTotalCheckouts,''),
TotalRenewals = NULLIF(@vTotalRenewals,''),
AgeRange = NULLIF(@vAgeRange,''),
HomeLibraryCode = NULLIF(@vHomeLibraryCode,''),
HomeLibraryDefinition = NULLIF(@vHomeLibraryDefinition,''),
CirculationActiveMonth = NULLIF(@vCirculationActiveMonth,''),
CirculationActiveYear = NULLIF(@vCirculationActiveYear,''),
NotificationPreferenceCode = NULLIF(@vNotificationPreferenceCode,''),
NotificationCodeDefinition = NULLIF(@vNotificationCodeDefinition,''),
ProvidedEmailAddress = NULLIF(@vProvidedEmailAddress,''),
WithinSanFranciscoCounty = NULLIF(@vWithinSanFranciscoCounty,''),
YearPatronRegistered = NULLIF(@vYearPatronRegistered,'');

# 3NF

CREATE TABLE PATRON_TYPE (
    Code INT PRIMARY KEY,
    Definition VARCHAR(255)
);

CREATE TABLE HOME_LIBRARY (
    Code VARCHAR(255) PRIMARY KEY,
    Definition VARCHAR(255)
);

CREATE TABLE NOTIFICATION_PREFERENCE (
    Code VARCHAR(255) PRIMARY KEY,
    Definition VARCHAR(255)
);

INSERT IGNORE INTO PATRON_TYPE (Code, Definition)
SELECT PatronTypeCode, PatronTypeDefinition
FROM MAIN;

INSERT IGNORE INTO HOME_LIBRARY (Code, Definition)
SELECT HomeLibraryCode, HomeLibraryDefinition
FROM MAIN;

INSERT IGNORE INTO NOTIFICATION_PREFERENCE (Code, Definition)
SELECT NotificationPreferenceCode, NotificationCodeDefinition
FROM MAIN;

ALTER TABLE MAIN
DROP COLUMN PatronTypeDefinition;

ALTER TABLE MAIN
DROP COLUMN HomeLibraryDefinition;

ALTER TABLE MAIN
DROP COLUMN NotificationCodeDefinition;

ALTER TABLE MAIN
ADD CONSTRAINT fk_PatronTypeCode
FOREIGN KEY (PatronTypeCode)
REFERENCES PATRON_TYPE(Code);

ALTER TABLE MAIN
ADD CONSTRAINT fk_HomeLibraryCode
FOREIGN KEY (HomeLibraryCode)
REFERENCES HOME_LIBRARY(Code);

ALTER TABLE MAIN
ADD CONSTRAINT fk_NotificationPreferenceCode
FOREIGN KEY (NotificationPreferenceCode)
REFERENCES NOTIFICATION_PREFERENCE(Code);