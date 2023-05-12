const { Client } = require('pg');
const express = require('express');
const cors = require('cors');

const app = express();


// Enable CORS for all routes
app.use(cors());

// Create a new client instance
const client = new Client({
  host: 'localhost',
  port: '5432',
  database: 'gis_data',
  user: 'rahulnayanegali',
  password: 'rahul.1996',
});

// Connect to the database
client.connect((err) => {
  if (err) {
    console.error('Database connection error:', err.stack);
  } else {
    console.log('Connected to the database');
  }
});

app.get('/query', (req, res) => {
  const queryOne = `SELECT
                    amenity,
                    ST_X(ST_Transform(way, 4326)) AS longitude,
                    ST_Y(ST_Transform(way, 4326)) AS latitude
                      FROM
                        planet_osm_point
                        WHERE
                        amenity IS NOT NULL`;

  const queryTwo = `SELECT 
                    osm_id, name, 
                    ST_Y(way) AS latitude,
                    ST_X(way) AS longitude 
                      FROM planet_osm_point 
                      ORDER BY name IS NULL, name, osm_id;`

  client.query(queryOne, (err, result) => {
    if (err) {
      console.error('Error executing query:', err.stack);
    } else {
      const amenities = result.rows.map((row) => row.amenity);
      res.json(result.rows);
    }
  });})

app.listen(8000, () => {
  console.log('Server listening on port 8000');
});