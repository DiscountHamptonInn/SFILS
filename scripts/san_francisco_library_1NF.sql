CREATE DATABASE san_francisco_library_1NF;

USE san_francisco_library_1NF;

CREATE TABLE LIBRARY (
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
INTO TABLE LIBRARY
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