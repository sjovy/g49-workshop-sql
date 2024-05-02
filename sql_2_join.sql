# SQL Join exercise
#

#
# 1: Get the cities with a name starting with ping sorted by their population with the least populated cities first
SELECT *
FROM City
WHERE Name LIKE 'Ping%'
ORDER BY Population ASC;
#
#
# 2: Get the cities with a name starting with ran sorted by their population with the most populated cities first
SELECT *
FROM City
WHERE Name LIKE 'Ran%'
ORDER BY Population DESC;
#
#
# 3: Count all cities
SELECT COUNT(*) AS TotalCities
FROM City;
#
#
# 4: Get the average population of all cities
SELECT AVG(Population) AS AveragePopulation
FROM City;
#
#
# 5: Get the biggest population found in any of the cities
SELECT MAX(Population) AS LargestPopulation
FROM City;
#
#
# 6: Get the smallest population found in any of the cities
SELECT MIN(Population) AS SmallestPopulation
FROM City;
#
#
# 7: Sum the population of all cities with a population below 10000
SELECT SUM(Population) AS TotalPopulation
FROM City
WHERE Population < 10000;
#
#
# 8: Count the cities with the countrycodes MOZ and VNM
SELECT COUNT(*) AS NumberOfCities
FROM City
WHERE CountryCode IN ('MOZ', 'VNM');
#
#
# 9: Get individual count of cities for the countrycodes MOZ and VNM
SELECT CountryCode, COUNT(*) AS NumberOfCities
FROM City
WHERE CountryCode IN ('MOZ', 'VNM')
GROUP BY CountryCode;
#
#
# 10: Get average population of cities in MOZ and VNM
SELECT CountryCode, AVG(Population) AS AveragePopulation
FROM City
WHERE CountryCode IN ('MOZ', 'VNM')
GROUP BY CountryCode;
#
#
# 11: Get the countrycodes with more than 200 cities
SELECT CountryCode, COUNT(*) AS CityCount
FROM City
GROUP BY CountryCode
HAVING COUNT(*) > 200;
#
#
# 12: Get the countrycodes with more than 200 cities ordered by city count
SELECT CountryCode, COUNT(*) AS CityCount
FROM City
GROUP BY CountryCode
HAVING COUNT(*) > 200
ORDER BY COUNT(*) DESC;
#
#
# 13: What language(s) is spoken in the city with a population between 400 and 500 ?
SELECT CountryLanguage.Language, City.Name, City.Population
FROM City
INNER JOIN Country ON City.CountryCode = Country.Code
INNER JOIN CountryLanguage ON Country.Code = CountryLanguage.CountryCode
WHERE City.Population BETWEEN 400 AND 500;
#
#
# 14: What are the name(s) of the cities with a population between 500 and 600 people and the language(s) spoken in them
SELECT City.Name AS CityName, CountryLanguage.Language
FROM City
JOIN Country ON City.CountryCode = Country.Code
JOIN CountryLanguage ON Country.Code = CountryLanguage.CountryCode
WHERE City.Population BETWEEN 500 AND 600;
#
#
# 15: What names of the cities are in the same country as the city with a population of 122199 (including the that city itself)
#
#
# 16: What names of the cities are in the same country as the city with a population of 122199 (excluding the that city itself)
SELECT name 
FROM City 
WHERE Population = 122199;

SELECT Name
FROM City
WHERE CountryCode = (
    SELECT CountryCode
    FROM City
    WHERE Population = 122199
);

#
#
# 17: What are the city names in the country where Luanda is capital?
SELECT City.Name
FROM City
JOIN Country ON City.CountryCode = Country.Code
WHERE Country.Capital = 'Luanda';

SELECT City.Name
FROM City
JOIN Country ON City.CountryCode = Country.Code
WHERE Country.Capital = (
    SELECT Id 
    FROM City 
    WHERE Name = 'Luanda'
);
#
#
# 18: What are the names of the capital cities in countries in the same region as the city named Yaren
SELECT CapitalCities.Name AS CapitalCityName
FROM Country AS RegionCountries
JOIN City AS CapitalCities ON RegionCountries.Capital = CapitalCities.Id
WHERE RegionCountries.Region = (
    SELECT Country.Region
    FROM City
    JOIN Country ON City.CountryCode = Country.Code
    WHERE City.Name = 'Yaren'
);
#
#
# 19: What unique languages are spoken in the countries in the same region as the city named Riga
SELECT DISTINCT CountryLanguage.Language
FROM CountryLanguage
JOIN Country ON CountryLanguage.CountryCode = Country.Code
WHERE Country.Region = (
    SELECT Country.Region
    FROM City
    JOIN Country ON City.CountryCode = Country.Code
    WHERE City.Name = 'Riga'
);
#
#
# 20: Get the name of the most populous city
SELECT Name, Population
FROM City
WHERE Population = (
    SELECT MAX(Population)
    FROM City
);
#
