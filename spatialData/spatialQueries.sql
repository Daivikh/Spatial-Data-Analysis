-- Display only columns of each table
SELECT column_name FROM information_schema.columns WHERE table_name = 'planet_osm_line'
SELECT column_name FROM information_schema.columns WHERE table_name = 'planet_osm_point'
SELECT column_name FROM information_schema.columns WHERE table_name = 'planet_osm_polygon'
SELECT column_name FROM information_schema.columns WHERE table_name = 'planet_osm_roads'


-- Retrieve osm_id, name, latitude, and longitude from planet_osm_point table
-- Order the results to display non-null name rows first, then sort by name and osm_id
SELECT osm_id, name, ST_Y(way) AS latitude, ST_X(way) AS longitude 
FROM planet_osm_point 
ORDER BY name IS NULL, name, osm_id;


-- Area of Interest 
/* This query retrieves the osm_id, name, operator,
building, and area of polygons from 
the planet_osm_polygon table */
SELECT
  osm_id,
  name,
  operator,
  building,
  ST_Area(way) AS area
FROM
  planet_osm_polygon;


/* This query retrieves the top 10 amenities from 
the planet_osm_point table based on their count, 
in descending order */
SELECT amenity, COUNT(*) AS count
FROM planet_osm_point
GROUP BY amenity
ORDER BY count DESC
LIMIT 10;


-- Distance between points
/* This query retrieves the osm_id and names of two points 
(point1 and point2) from the planet_osm_point table, 
along with the calculated distance between them. 
The points are specified by their respective osm_id values (5798777127 and 5243565196). 
The distance is calculated using the ST_Distance function on the transformed geometry (way) of the points. 
The results are ordered in ascending order based on the distance. */
SELECT
  p1.osm_id AS point1_osm_id,
  p2.osm_id AS point2_osm_id,
  p1.name,
  p2.name,
  ST_Distance(ST_Transform(p1.way, 4326)::geography, ST_Transform(p2.way, 4326)::geography) AS distance
FROM
  planet_osm_point AS p1
CROSS JOIN
  planet_osm_point AS p2
WHERE
  p1.osm_id = 5798777127 AND
  p2.osm_id = 5243565196
ORDER BY distance ASC
LIMIT 1;


/* This query retrieves the osm_id, name, operator, building, and area of polygons 
from the planet_osm_polygon table. 
The polygons are ordered in descending order based on their area. */
SELECT
  osm_id,
  name,
  operator,
  building,
  ST_Area(way) AS area
FROM
  planet_osm_polygon
ORDER BY area DESC
LIMIT 5;


-- Indexing
/* These two SQL statements create indexes on the specified columns of the respective tables:

Indexes are used to improve the performance of database queries by creating a data structure that 
allows for faster lookup and retrieval of data based on the indexed column(s).*/

CREATE INDEX idx_planet_osm_polygon_way ON planet_osm_polygon USING GIST (way);

CREATE INDEX idx_osm_id ON planet_osm_point (osm_id);

SELECT
  p1.osm_id AS point1_osm_id,
  p2.osm_id AS point2_osm_id,
  p1.name,
  p2.name,
  ST_Distance(ST_Transform(p1.way, 4326)::geography, ST_Transform(p2.way, 4326)::geography) AS distance
FROM
  planet_osm_point AS p1
CROSS JOIN
  planet_osm_point AS p2
WHERE
  p1.osm_id = 5798777127 AND
  p2.osm_id = 5243565196

SELECT amenity, COUNT(*) AS count
FROM planet_osm_point
GROUP BY amenity;


/* This query retrieves the amenity, osm_id, longitude, and latitude of points 
from the planet_osm_point table where the amenity is not null. 
The coordinates are transformed to the WGS84 (4326) coordinate reference system using 
the ST_Transform function. The ST_X and ST_Y functions extract the longitude and latitude respectively 
from the transformed geometry (way) of the points. */
SELECT
amenity,
osm_id,
ST_X(ST_Transform(way, 4326)) AS longitude,
ST_Y(ST_Transform(way, 4326)) AS latitude
	FROM planet_osm_point
    WHERE amenity IS NOT NULL
	limit(1)
	  





