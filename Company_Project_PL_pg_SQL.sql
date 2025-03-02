-- postgres
CREATE DATABASE Company_Project_PL_pg_SQL;
-- Company_Project_PL_pg_SQL 
-- Admin User
CREATE USER Panos_Chron /*WITH*/ LOGIN PASSWORD 'Panos_Chron';
COMMIT;
--
CREATE USER Panos_Chron1 /*WITH*/ LOGIN PASSWORD 'Panos_Chron1';
COMMIT;
--
GRANT CONNECT ON DATABASE Company_Project_PL_pg_SQL TO Panos_Chron;
COMMIT;
--
GRANT USAGE ON SCHEMA Public TO Panos_Chron;
COMMIT;
--
GRANT CONNECT ON DATABASE Company_Project_PL_pg_SQL TO Panos_Chron1;
COMMIT;
--
GRANT USAGE ON SCHEMA Public TO Panos_Chron1;
COMMIT;
--
CREATE TABLE IF NOT EXISTS Companies
(
CompanyID INTEGER NOT NULL,
CompanyName VARCHAR(50) NOT NULL,
CompanyNameXML XML NOT NULL,
CompanyNameJSON JSONB NOT NULL,
CONSTRAINT CompanyID_PK PRIMARY KEY (CompanyID),
CONSTRAINT CompanyName_UNQ UNIQUE (CompanyName),
CONSTRAINT CompanyNameXML_CHK CHECK (CompanyNameXML IS NOT NULL),
CONSTRAINT CompanyNameJSON_CHK CHECK (JSONB_TYPEOF(CompanyNameJSON) = 'object')
);
COMMIT;
--
CREATE TABLE IF NOT EXISTS CompaniesLog
(
CompanyID INTEGER NOT NULL,
CompanyName VARCHAR(50) NOT NULL,
DataManipulationLangugageStatement VARCHAR(50) NOT NULL,
TrackOfTransactions TIMESTAMP DEFAULT NOW(),
CONSTRAINT DataManipulationLangugageStatement_CHK_Company CHECK (DataManipulationLangugageStatement IN ('Insert Statement', 'Update Statement', 'Delete Statement'))
);
COMMIT;
--
CREATE OR REPLACE FUNCTION CompaniesDMLStatementsBefore() RETURNS TRIGGER 
LANGUAGE PLPGSQL AS $$
BEGIN
IF TG_OP = 'INSERT' THEN
INSERT INTO CompaniesLog (CompanyID, CompanyName, DataManipulationLangugageStatement) VALUES (NEW.CompanyID, NEW.CompanyName, 'Insert Statement');
RAISE NOTICE 'Inserted Successfull.';
RETURN NEW;
ELSIF TG_OP = 'UPDATE' THEN
INSERT INTO CompaniesLog (CompanyID, CompanyName, DataManipulationLangugageStatement) VALUES (OLD.CompanyID, OLD.CompanyName, 'Update Statement');
RAISE NOTICE 'Updated Successfull.';
RETURN NEW;
ELSIF TG_OP = 'DELETE' THEN
INSERT INTO CompaniesLog (CompanyID, CompanyName, DataManipulationLangugageStatement) VALUES (OLD.CompanyID, OLD.CompanyName, 'Delete Statement');
RAISE NOTICE 'Deleted Successfull.';
RETURN OLD;
END IF;
RETURN NULL;
END;
$$;
COMMIT;
--
CREATE OR REPLACE TRIGGER CompaniesDMLStatementsBefore_T 
BEFORE INSERT OR UPDATE OR DELETE ON Companies
FOR EACH ROW
EXECUTE PROCEDURE CompaniesDMLStatementsBefore();
COMMIT;
--
INSERT INTO Companies (CompanyID, CompanyName, CompanyNameXML, CompanyNameJSON) VALUES (1, 'Amazon', '<CompanyName>Amazon</CompanyName>', '{"CompanyName": "Amazon"}');
INSERT INTO Companies (CompanyID, CompanyName, CompanyNameXML, CompanyNameJSON) VALUES (2, 'Google', '<CompanyName>Google</CompanyName>', '{"CompanyName": "Google"}');
INSERT INTO Companies (CompanyID, CompanyName, CompanyNameXML, CompanyNameJSON) VALUES (3, 'Microsoft', '<CompanyName>Microsoft</CompanyName>', '{"CompanyName": "Microsoft"}');
INSERT INTO Companies (CompanyID, CompanyName, CompanyNameXML, CompanyNameJSON) VALUES (4, 'Apple', '<CompanyName>Apple</CompanyName>', '{"CompanyName": "Apple"}');
INSERT INTO Companies (CompanyID, CompanyName, CompanyNameXML, CompanyNameJSON) VALUES (5, 'Facebook', '<CompanyName>Facebook</CompanyName>', '{"CompanyName": "Facebook"}');
INSERT INTO Companies (CompanyID, CompanyName, CompanyNameXML, CompanyNameJSON) VALUES (6, 'Twitter', '<CompanyName>Twitter</CompanyName>', '{"CompanyName": "Twitter"}');
INSERT INTO Companies (CompanyID, CompanyName, CompanyNameXML, CompanyNameJSON) VALUES (7, 'IBM', '<CompanyName>IBM</CompanyName>', '{"CompanyName": "IBM"}');
INSERT INTO Companies (CompanyID, CompanyName, CompanyNameXML, CompanyNameJSON) VALUES (8, 'Intel', '<CompanyName>Intel</CompanyName>', '{"CompanyName": "Intel"}');
INSERT INTO Companies (CompanyID, CompanyName, CompanyNameXML, CompanyNameJSON) VALUES (9, 'Oracle', '<CompanyName>Oracle</CompanyName>', '{"CompanyName": "Oracle"}');
INSERT INTO Companies (CompanyID, CompanyName, CompanyNameXML, CompanyNameJSON) VALUES (10, 'Tesla', '<CompanyName>Tesla</CompanyName>', '{"CompanyName": "Tesla"}');
INSERT INTO Companies (CompanyID, CompanyName, CompanyNameXML, CompanyNameJSON) VALUES (11, 'Samsung', '<CompanyName>Samsung</CompanyName>', '{"CompanyName": "Samsung"}');
INSERT INTO Companies (CompanyID, CompanyName, CompanyNameXML, CompanyNameJSON) VALUES (12, 'Sony', '<CompanyName>Sony</CompanyName>', '{"CompanyName": "Sony"}');
INSERT INTO Companies (CompanyID, CompanyName, CompanyNameXML, CompanyNameJSON) VALUES (13, 'Nvidia', '<CompanyName>Nvidia</CompanyName>', '{"CompanyName": "Nvidia"}');
INSERT INTO Companies (CompanyID, CompanyName, CompanyNameXML, CompanyNameJSON) VALUES (14, 'Adobe', '<CompanyName>Adope</CompanyName>', '{"CompanyName": "Adope"}');
INSERT INTO Companies (CompanyID, CompanyName, CompanyNameXML, CompanyNameJSON) VALUES (15, 'Salesforce', '<CompanyName>Salesforce</CompanyName>', '{"CompanyName": "Salesforce"}');
INSERT INTO Companies (CompanyID, CompanyName, CompanyNameXML, CompanyNameJSON) VALUES (16, 'Alibaba', '<CompanyName>Alibaba</CompanyName>', '{"CompanyName": "Alibaba"}');
INSERT INTO Companies (CompanyID, CompanyName, CompanyNameXML, CompanyNameJSON) VALUES (17, 'Zoom', '<CompanyName>Zoom</CompanyName>', '{"CompanyName": "Zoom"}');
INSERT INTO Companies (CompanyID, CompanyName, CompanyNameXML, CompanyNameJSON) VALUES (18, 'Slack', '<CompanyName>Slack</CompanyName>', '{"CompanyName": "Slack"}');
INSERT INTO Companies (CompanyID, CompanyName, CompanyNameXML, CompanyNameJSON) VALUES (19, 'Spotify', '<CompanyName>Spotify</CompanyName>', '{"CompanyName": "Spotify"}');
INSERT INTO Companies (CompanyID, CompanyName, CompanyNameXML, CompanyNameJSON) VALUES (20, 'PayPal', '<CompanyName>Paypal</CompanyName>', '{"CompanyName": "Paypal"}');
INSERT INTO Companies (CompanyID, CompanyName, CompanyNameXML, CompanyNameJSON) VALUES (21, 'Netflix', '<CompanyName>Netflix</CompanyName>', '{"CompanyName": "Netflix"}');
INSERT INTO Companies (CompanyID, CompanyName, CompanyNameXML, CompanyNameJSON) VALUES (22, 'eBay', '<CompanyName>eBay</CompanyName>', '{"CompanyName": "eBay"}');
INSERT INTO Companies (CompanyID, CompanyName, CompanyNameXML, CompanyNameJSON) VALUES (23, 'LinkedIn', '<CompanyName>LinkedIn</CompanyName>', '{"CompanyName": "LinkedIn"}');
INSERT INTO Companies (CompanyID, CompanyName, CompanyNameXML, CompanyNameJSON) VALUES (24, 'Uber', '<CompanyName>Uber</CompanyName>', '{"CompanyName": "Uber"}');
INSERT INTO Companies (CompanyID, CompanyName, CompanyNameXML, CompanyNameJSON) VALUES (25, 'Lyft', '<CompanyName>Lyft</CompanyName>', '{"CompanyName": "Lyft"}');
INSERT INTO Companies (CompanyID, CompanyName, CompanyNameXML, CompanyNameJSON) VALUES (26, 'Shopify', '<CompanyName>Shopify</CompanyName>', '{"CompanyName": "Shopify"}');
INSERT INTO Companies (CompanyID, CompanyName, CompanyNameXML, CompanyNameJSON) VALUES (27, 'Square', '<CompanyName>Square</CompanyName>', '{"CompanyName": "Square"}');
INSERT INTO Companies (CompanyID, CompanyName, CompanyNameXML, CompanyNameJSON) VALUES (28, 'Dropbox', '<CompanyName>Dropbox</CompanyName>', '{"CompanyName": "Dropbox"}');
INSERT INTO Companies (CompanyID, CompanyName, CompanyNameXML, CompanyNameJSON) VALUES (29, 'Pinterest', '<CompanyName>Pinterest</CompanyName>', '{"CompanyName": "Pinterest"}');
INSERT INTO Companies (CompanyID, CompanyName, CompanyNameXML, CompanyNameJSON) VALUES (30, 'Reddit', '<CompanyName>Reddit</CompanyName>', '{"CompanyName": "Reddit"}');
COMMIT;
--
SELECT * FROM Companies;
SELECT * FROM CompaniesLog;
--
UPDATE Companies SET CompanyID = 31 WHERE CompanyID = 1;
COMMIT;
--
SELECT * FROM Companies;
SELECT * FROM CompaniesLog;
--
DELETE FROM Companies WHERE CompanyID = 31;
COMMIT;
--
SELECT * FROM Companies;
SELECT * FROM CompaniesLog;
--
CREATE OR REPLACE VIEW MaskedCompanies AS SELECT CompanyID FROM Companies;
COMMIT;
--
GRANT SELECT ON MaskedCompanies TO Panos_Chron WITH GRANT OPTION;
COMMIT;
-- Panos_Chron User
SET ROLE Panos_Chron;
SELECT * FROM MaskedCompanies;
GRANT SELECT ON MaskedCompanies TO Panos_Chron1;
COMMIT;
RESET ROLE;
COMMIT;
-- Panos_Chron1 User
SET ROLE Panos_Chron1;
SELECT * FROM MaskedCompanies;
RESET ROLE;
COMMIT;
-- Admin User
CREATE TABLE IF NOT EXISTS Locations
(
LocationID INTEGER NOT NULL,
GeographicalLocation POINT NOT NULL,
CompanyID INTEGER NOT NULL,
CONSTRAINT LocationID_PK PRIMARY KEY (LocationID),
CONSTRAINT CompanyID_FK FOREIGN KEY (CompanyID) REFERENCES Companies (CompanyID) ON DELETE CASCADE ON UPDATE CASCADE
);
COMMIT;
-- 
CREATE TABLE IF NOT EXISTS LocationsLog
(
LocationID INTEGER NOT NULL,
GeographicalLocation POINT NOT NULL,
CompanyID INTEGER NOT NULL,
DataManipulationLanguageStatement VARCHAR(50) NOT NULL,
TrackOfTransactions TIMESTAMP DEFAULT NOW(),
CONSTRAINT DataManipulationLanguageStatement_CHK_Location CHECK (DataManipulationLanguageStatement IN ('Insert Statement', 'Update Statement', 'Delete Statement'))
);
COMMIT;
-- 
CREATE OR REPLACE FUNCTION LocationsInsertStatementsBefore() RETURNS TRIGGER 
LANGUAGE PLPGSQL AS $$
BEGIN
IF TG_OP = 'INSERT' THEN
INSERT INTO LocationsLog (LocationID, GeographicalLocation, CompanyID, DataManipulationLanguageStatement) VALUES (NEW.LocationID, NEW.GeographicalLocation, NEW.CompanyID, 'Insert Statement');
RAISE NOTICE 'Inserted Successfull.';
RETURN NEW;
ELSIF TG_OP = 'UPDATE' THEN
INSERT INTO LocationsLog (LocationID, GeographicalLocation, CompanyID, DataManipulationLanguageStatement) VALUES (OLD.LocationID, OLD.GeographicalLocation, OLD.CompanyID, 'Update Statement');
RAISE NOTICE 'Updated Successfull.';
RETURN NEW;
ELSIF TG_OP = 'DELETE' THEN
INSERT INTO LocationsLog (LocationID, GeographicalLocation, CompanyID, DataManipulationLanguageStatement) VALUES (OLD.LocationID, OLD.GeographicalLocation, OLD.CompanyID, 'Delete Statement');
RAISE NOTICE 'Deleted Successfull.';
RETURN OLD;
END IF;
RETURN NULL;
END;
$$;
COMMIT;
--
CREATE OR REPLACE TRIGGER LocationsInsertStatementsBefore_T 
BEFORE INSERT OR UPDATE OR DELETE ON Locations
FOR EACH ROW
EXECUTE PROCEDURE LocationsInsertStatementsBefore();
COMMIT;
--
INSERT INTO Locations (LocationID, GeographicalLocation, CompanyID) VALUES (1, POINT(-122.3321, 47.6062), 1);
INSERT INTO Locations (LocationID, GeographicalLocation, CompanyID) VALUES (2, POINT(-122.4194, 37.7749), 2);
INSERT INTO Locations (LocationID, GeographicalLocation, CompanyID) VALUES (3, POINT(23.7275, 37.9838), 3);
INSERT INTO Locations (LocationID, GeographicalLocation, CompanyID) VALUES (4, POINT(-122.0312, 37.3318), 4);
INSERT INTO Locations (LocationID, GeographicalLocation, CompanyID) VALUES (5, POINT(-74.0060, 40.7128), 5);
INSERT INTO Locations (LocationID, GeographicalLocation, CompanyID) VALUES (6, POINT(-0.1278, 51.5074), 6);
INSERT INTO Locations (LocationID, GeographicalLocation, CompanyID) VALUES (7, POINT(139.6917, 35.6895), 7);
INSERT INTO Locations (LocationID, GeographicalLocation, CompanyID) VALUES (8, POINT(2.3522, 48.8566), 8);
INSERT INTO Locations (LocationID, GeographicalLocation, CompanyID) VALUES (9, POINT(-118.2437, 34.0522), 9);
INSERT INTO Locations (LocationID, GeographicalLocation, CompanyID) VALUES (10, POINT(12.4964, 41.9028), 10);
INSERT INTO Locations (LocationID, GeographicalLocation, CompanyID) VALUES (11, POINT(116.4074, 39.9042), 11);
INSERT INTO Locations (LocationID, GeographicalLocation, CompanyID) VALUES (12, POINT(151.2093, -33.8688), 12);
INSERT INTO Locations (LocationID, GeographicalLocation, CompanyID) VALUES (13, POINT(37.6173, 55.7558), 13);
INSERT INTO Locations (LocationID, GeographicalLocation, CompanyID) VALUES (14, POINT(-104.9903, 39.7392), 14);
INSERT INTO Locations (LocationID, GeographicalLocation, CompanyID) VALUES (15, POINT(-46.6333, -23.5505), 15);
INSERT INTO Locations (LocationID, GeographicalLocation, CompanyID) VALUES (16, POINT(-73.9352, 40.7306), 16);
INSERT INTO Locations (LocationID, GeographicalLocation, CompanyID) VALUES (17, POINT(-97.7431, 30.2672), 17);
INSERT INTO Locations (LocationID, GeographicalLocation, CompanyID) VALUES (18, POINT(-86.7816, 36.1627), 18);
INSERT INTO Locations (LocationID, GeographicalLocation, CompanyID) VALUES (19, POINT(-79.3470, 43.6510), 19);
INSERT INTO Locations (LocationID, GeographicalLocation, CompanyID) VALUES (20, POINT(13.4050, 52.5200), 20);
INSERT INTO Locations (LocationID, GeographicalLocation, CompanyID) VALUES (21, POINT(-3.1883, 55.9533), 21);
INSERT INTO Locations (LocationID, GeographicalLocation, CompanyID) VALUES (22, POINT(24.9354, 60.1695), 22);
INSERT INTO Locations (LocationID, GeographicalLocation, CompanyID) VALUES (23, POINT(10.4515, 51.1657), 23);
INSERT INTO Locations (LocationID, GeographicalLocation, CompanyID) VALUES (24, POINT(139.6503, 35.6762), 24);
INSERT INTO Locations (LocationID, GeographicalLocation, CompanyID) VALUES (25, POINT(-58.3816, -34.6037), 25);
INSERT INTO Locations (LocationID, GeographicalLocation, CompanyID) VALUES (26, POINT(90.4125, 23.8103), 26);
INSERT INTO Locations (LocationID, GeographicalLocation, CompanyID) VALUES (27, POINT(100.9925, 15.8700), 27);
INSERT INTO Locations (LocationID, GeographicalLocation, CompanyID) VALUES (28, POINT(11.5820, 48.1351), 28);
INSERT INTO Locations (LocationID, GeographicalLocation, CompanyID) VALUES (29, POINT(103.8198, 1.3521), 29);
INSERT INTO Locations (LocationID, GeographicalLocation, CompanyID) VALUES (30, POINT(116.4040, 39.9138), 30);
COMMIT;
-- 
SELECT * FROM Locations;
SELECT * FROM LocationsLog;
-- 
UPDATE Locations SET LocationID = 31 WHERE LocationID = 1;
COMMIT;
-- 
SELECT * FROM Locations;
SELECT * FROM LocationsLog;
-- 
DELETE FROM Locations WHERE LocationID = 31;
COMMIT;
-- 
SELECT * FROM Locations;
SELECT * FROM LocationsLog;
-- 
CREATE OR REPLACE VIEW MaskedLocations AS SELECT LocationID, CompanyID FROM Locations;
COMMIT;
-- 
GRANT SELECT ON MaskedLocations TO Panos_Chron WITH GRANT OPTION;
COMMIT;
-- Panos_Chron User
SET ROLE Panos_Chron;
SELECT * FROM MaskedLocations;
GRANT SELECT ON MaskedLocations TO Panos_Chron1;
COMMIT;
RESET ROLE;
COMMIT;
-- Panos_Chron1 User
SET ROLE Panos_Chron1;
SELECT * FROM MaskedLocations;
RESET ROLE;
COMMIT;
--
--
--
--
--
-- Company_Project_PL_pg_SQL 
-- Panos_Chron User
SET ROLE Panos_Chron;
SELECT * FROM MaskedLocations;
REVOKE SELECT ON MaskedLocations FROM Panos_Chron1;
COMMIT;
RESET ROLE;
COMMIT;
-- Panos_Chron1 User
SET ROLE Panos_Chron1;
SELECT * FROM MaskedLocations;
COMMIT;
RESET ROLE;
COMMIT;
-- Admin User
REVOKE SELECT ON MaskedLocations FROM Panos_Chron CASCADE;
COMMIT;
--
DROP VIEW IF EXISTS MaskedLocations;
COMMIT;
--
ALTER TABLE IF EXISTS Locations ENABLE TRIGGER LocationsInsertStatementsBefore_T;
ALTER TABLE IF EXISTS Locations DISABLE TRIGGER LocationsInsertStatementsBefore_T;
DROP TRIGGER IF EXISTS LocationsInsertStatementsBefore_T ON Locations;
COMMIT;
--
DROP FUNCTION IF EXISTS LocationsInsertStatementsBefore;
COMMIT;
--
DELETE FROM LocationsLog;
COMMIT;
--
TRUNCATE TABLE LocationsLog;
COMMIT;
-- 
ALTER TABLE IF EXISTS LocationsLog DROP CONSTRAINT IF EXISTS DataManipulationLanguageStatement_CHK_Location;
COMMIT;
-- 
DROP TABLE IF EXISTS LocationsLog;
COMMIT;
-- 
DELETE FROM Locations;
COMMIT;
--
TRUNCATE TABLE Locations;
COMMIT;
-- 
ALTER TABLE IF EXISTS Locations DROP CONSTRAINT IF EXISTS CompanyID_FK;
COMMIT;
-- 
ALTER TABLE IF EXISTS Locations DROP CONSTRAINT IF EXISTS LocationID_PK;
COMMIT;
-- 
DROP TABLE IF EXISTS Locations;
COMMIT;
-- Panos_Chron User
SET ROLE Panos_Chron;
SELECT * FROM MaskedCompanies;
REVOKE SELECT ON MaskedCompanies FROM Panos_Chron1;
COMMIT;
RESET ROLE;
COMMIT;
-- Panos_Chron1 User
SET ROLE Panos_Chron1;
SELECT * FROM MaskedCompanies;
COMMIT;
RESET ROLE;
COMMIT;
-- Admin User
REVOKE SELECT ON MaskedCompanies FROM Panos_Chron CASCADE;
COMMIT;
--
DROP VIEW IF EXISTS MaskedCompanies;
COMMIT;
--
ALTER TABLE IF EXISTS Companies ENABLE TRIGGER CompaniesDMLStatementsBefore_T;
ALTER TABLE IF EXISTS Companies DISABLE TRIGGER CompaniesDMLStatementsBefore_T;
DROP TRIGGER IF EXISTS CompaniesDMLStatementsBefore_T ON Companies;
COMMIT;
--
DROP FUNCTION IF EXISTS CompaniesDMLStatementsBefore;
COMMIT;
--
DELETE FROM CompaniesLog;
COMMIT;
--
TRUNCATE TABLE CompaniesLog;
COMMIT;
--
ALTER TABLE IF EXISTS CompaniesLog DROP CONSTRAINT IF EXISTS DataManipulationLangugageStatement_CHK_Company;
COMMIT;
--
DROP TABLE IF EXISTS CompaniesLog;
COMMIT;
--
DELETE FROM Companies;
COMMIT;
--
TRUNCATE TABLE Companies;
COMMIT;
--
ALTER TABLE IF EXISTS Companies DROP CONSTRAINT IF EXISTS CompanyNameJSON_CHK;
COMMIT;
--
ALTER TABLE IF EXISTS Companies DROP CONSTRAINT IF EXISTS CompanyNameXML_CHK;
COMMIT;
--
ALTER TABLE IF EXISTS Companies DROP CONSTRAINT IF EXISTS CompanyName_UNQ;
COMMIT;
--
ALTER TABLE IF EXISTS Companies DROP CONSTRAINT IF EXISTS CompanyID_PK;
COMMIT;
--
DROP TABLE IF EXISTS Companies;
COMMIT;
--
REVOKE USAGE ON SCHEMA Public FROM Panos_Chron1;
COMMIT;
--
REVOKE CONNECT ON DATABASE Company_Project_PL_pg_SQL FROM Panos_Chron1;
COMMIT;
--
REVOKE USAGE ON SCHEMA Public FROM Panos_Chron;
COMMIT;
--
REVOKE CONNECT ON DATABASE Company_Project_PL_pg_SQL FROM Panos_Chron;
COMMIT;
--
DROP USER IF EXISTS Panos_Chron1;
COMMIT;
--
DROP USER IF EXISTS Panos_Chron;
COMMIT;
-- postgres
DROP DATABASE IF EXISTS Company_Project_PL_pg_SQL;