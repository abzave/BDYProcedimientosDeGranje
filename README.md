# Chicken Farm SQL Server Database

This project is a simple SQL Server database for a chicken farm. The goal of the project is to understand database normalization, SQL queries and stored procedures.

## Table of Contents
1. [Project Overview](#project-overview)
2. [Features](#features)
3. [Requirements](#requirements)
4. [How to Run](#how-to-run)

## Project Overview

This chicken farm database project manages the create, read, update and delete of the data using stored procedures to ensure data integrity.

The structure of the database is the following:

<img width="3812" height="1580" alt="image" src="https://github.com/user-attachments/assets/0cd8fb02-9d4d-48c2-ae87-0872d46facf0" />

## Features

- **Farm Production Reporting**: Gets the amount of eggs produced by farm, chicken and egg type.
- **Egg Orders Reporting**: Reports information about the average amount of eggs by order.
- **Order Creation**: Creates new orders in the database and its respective invoice. 

## Requirements

- **SQL Server**: A SQL Server instance with permissions to create, read, update and delete.

## How to Run

### Step 1: Clone the repository

``` bash
git clone https://github.com/abzave/BDYProcedimientosDeGranje.git
cd BDYProcedimientosDeGranje
```

### Step 2: Create the database tables

Create a new database and run the file named `DBCreate.sql` to create all the tables required.

### Step 3: Create the stored procedures

Run the file named `storedProcedures.sql` to create the stored procedures in the database.
