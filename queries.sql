-- 3) How many females and how many male passengers travelled for a minimum distance of 600 KMs?
SELECT COUNT(CASE WHEN Gender = 'M' AND Distance >= 600 THEN 1 END) AS Male,
COUNT(CASE WHEN Gender = 'F' AND Distance >= 600 THEN 1 END) AS Female FROM PASSENGER;

-- 4) Find the minimum ticket price for Sleeper Bus.
SELECT minimum.Price AS Minimum_Price FROM PRICE minimum INNER JOIN 
(SELECT Bus_Type, MIN(Price) AS Minimum FROM PRICE GROUP BY Bus_Type
HAVING Bus_Type = 'Sleeper') s ON minimum.Bus_Type = s.Bus_Type AND minimum.Price = s.Minimum;

-- 5) Select passenger names whose names start with character 'S'.
SELECT p.Passenger_name FROM PASSENGER p WHERE p.Passenger_name LIKE 'S%';

-- 6) Calculate price charged for each passenger displaying Passenger name, Boarding City, Destination City, Bus_Type, Price in the output.
SELECT ps.Passenger_name,ps.Boarding_City,ps.Destination_City,ps.Bus_Type,p.Price
FROM PASSENGER ps INNER JOIN PRICE p ON ps.Bus_Type = p.Bus_Type 
AND ps.Distance = p.Distance GROUP BY Passenger_name;

-- 7) What are the passenger name/s and his/her ticket price who travelled in the Sitting bus for a distance of 1000 KMs.
SELECT ps.Passenger_name,p.Price FROM PASSENGER ps INNER JOIN PRICE p ON ps.Bus_Type = p.Bus_Type 
AND ps.Distance = p.Distance AND ps.Bus_Type = 'Sitting' AND ps.Distance = 1000 GROUP BY Passenger_name;

-- 8) What will be the Sitting and Sleeper bus charge for Pallavi to travel from Bangalore to Panaji?
SELECT Bus_Type,Price FROM PRICE WHERE Distance = (SELECT Distance FROM PASSENGER WHERE Passenger_name = 'Pallavi' 
AND Boarding_City IN ('Bengaluru','Panaji') AND Destination_City IN ('Bengaluru','Panaji'));

-- 9) List the distances from the "Passenger" table which are unique (non-repeated distances) in descending order.
SELECT DISTINCT Distance FROM PASSENGER ORDER BY Distance DESC;

-- 10) Display the passenger name and percentage of distance travelled by that passenger from the total distance travelled by all passengers without using user variables.
SELECT Passenger_name, (Distance/(SELECT SUM(Distance) FROM PASSENGER))*100 
AS PercentageDistance FROM PASSENGER GROUP BY Passenger_name;

-- 11) Display the distance, price in three categories in table Price
-- 		a) Expensive if the cost is more than 1000
-- 		b) Average Cost if the cost is less than 1000 and greater than 500
-- 		c) Cheap otherwise
SELECT Bus_Type,Distance,Price,
CASE
WHEN Price > 1000 THEN 'Expensive'
WHEN Price > 500 AND Price <= 1000 THEN 'Average Cost'
ELSE 'Cheap'
END AS Category FROM PRICE
GROUP BY Bus_Type,Distance ORDER BY Distance;