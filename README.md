# Company Project PL pg SQL

This repository contains PL/pgSQL code for a company project. It provides a structured database schema and sample data for managing companies, locations, departments, projects and employees along with logging and access control mechanisms.

## Features

-   Database schema creation for `Companies`, `Locations`, `Departments`, `Projects` and `Employees`.
-   Logging tables and triggers to track data manipulation statements.
-   Functions and procedures for data retrieval and manipulation.
-   User roles and access control using views and grants.
-   Sample data insertion for demonstration purposes.

## Table of Contents

-   [Installation](#installation)
-   [Usage](#usage)
-   [Dependencies](#dependencies)
  
## Installation

To set up the project, follow these steps:

1.  Clone the repository:

    ```bash
    git clone https://github.com/panoschron97/Company_Project_PL_pg_SQL.git
    cd Company_Project_PL_pg_SQL
    ```

2.  Install PostgreSQL:

    Ensure you have PostgreSQL installed and configured on your system.

3.  Create the database and users:

    Run the SQL script `Company_Project_PL_pg_SQL.sql` in a PostgreSQL environment to create the database, users and tables.

    ```bash
    psql -U postgres -f Company_Project_PL_pg_SQL.sql
    ```

## Usage

After installation connect to the `Company_Project_PL_pg_SQL` database with the appropriate user credentials to execute queries and manage the data.

Example queries:

```sql
-- Select all companies
SELECT * FROM Companies;

-- Select all employees
SELECT * FROM Employees;

-- Call a procedure to increase salaries
CALL IncreaseSalaries(100.00);
```

## Dependencies

-   **PostgreSQL:** A powerful open-source relational database system.
