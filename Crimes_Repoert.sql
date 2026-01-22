SELECT * FROM crimes.crime_reports;

# QUeries
use crimes;

show tables;
# 1.Crimes with Type, Status, City, and Description
SELECT cd.crime_id,ct.type_name AS Crime_Type,s.status_name AS Status,l.city AS City,cd.date_reported,cd.description
FROM Crimes_Done as cd 
JOIN Crimes_Type ct ON cd.crime_type_id = ct.crime_type_id
JOIN Status as s ON cd.status_id = s.status_id
JOIN Locations as l ON cd.location_id = l.location_id;

# 2.
SELECT cr.report_id,o.name AS Officer_Name,o.score,o.station_name,ct.type_name AS Crime_Type,cd.date_reported
FROM Crime_Reports as cr
JOIN Officers as o ON cr.officer_id = o.officer_id
JOIN Crimes_Done as cd ON cr.crime_id = cd.crime_id
JOIN Crimes_Type as ct ON cd.crime_type_id = ct.crime_type_id;


#3
SELECT l.city,COUNT(cd.crime_id) AS Total_Crimes
FROM crimes_done as cd
JOIN locations as l ON cd.location_id = l.location_id
GROUP BY l.city
ORDER BY Total_Crimes DESC;

#4
SELECT o.name AS Officer_Name,COUNT(cr.report_id) AS Cases_Handled
FROM crime_reports as cr
JOIN officers as o ON cr.officer_id = o.officer_id
GROUP BY o.name;

#5
CREATE VIEW open_cases AS
SELECT cd.crime_id,ct.type_name,l.city,cd.date_reported,s.status_name
FROM crimes_done as cd
JOIN crimes_type as ct ON cd.crime_type_id = ct.crime_type_id
JOIN locations as l ON cd.location_id = l.location_id
JOIN status as s ON cd.status_id = s.status_id
WHERE s.status_name = 'Open';

SELECT * FROM open_cases;


#6
SELECT v.name AS Victim_Name,COUNT(cr.report_id) AS Total_Cases
FROM crime_reports as cr
JOIN victims as v ON cr.victim_id = v.victim_id
GROUP BY v.name
HAVING COUNT(cr.report_id) > 1;


#7
SELECT YEAR(date_reported) AS Year,MONTH(date_reported) AS Month,COUNT(crime_id) AS Total_Crimes
FROM crimes_done
GROUP BY YEAR(date_reported), MONTH(date_reported)
ORDER BY Year, Month;
