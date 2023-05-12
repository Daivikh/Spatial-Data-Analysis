# GIS Data Visualization

This is a simple web application that retrieves GIS (Geographic Information System) data from a PostgreSQL database and visualizes it on a Leaflet map. The application is built using Node.js and Express for the backend, and it utilizes the Leaflet JavaScript library for displaying the map.

## Prerequisites

Before running the application, ensure that you have the following software installed:

- Node.js
- PostgreSQL

## Installation

1. Clone the repository:

```bash
git clone https://github.com/Daivikh/Spatial-Data-Analysis.git
```

2. Navigate to the project directory:

```bash
cd spatialData
```

3. Install the dependencies:

```bash
npm install
```

4. Set up the PostgreSQL database:

- Make sure PostgreSQL is installed and running on your system.
- Create a new database called `gis_data`.
- Modify the connection details (host, port, database, user, and password) in the `app.js` file to match your PostgreSQL configuration.

5. Start the server:

```bash
node server.js
```

The server will start running on port 8000.

6. Open the application in your web browser:

```bash
http://localhost:8000
```

You should see a Leaflet map with markers representing the GIS data retrieved from the database.

## Usage

The application provides a single endpoint `/query` that retrieves GIS data from the PostgreSQL database and returns it as JSON. The retrieved data is then displayed on the Leaflet map.
