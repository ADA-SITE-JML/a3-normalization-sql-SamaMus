[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-22041afd0340ce965d47ae6ef1cefeee28c7c493a6346c4f15d667ab976d596c.svg)](https://classroom.github.com/a/w1BdldVH)

### Database Normalization Assignment

## Overview
This project demonstrates the process of normalizing a database schema from unnormalized data through various normalization forms (1NF, 2NF, 3NF). The provided SQL scripts automate the entire process, from creating the initial table to performing all normalization steps. The procedures ensure that the database schema adheres to relational database design best practices, improving data integrity and reducing redundancy.

## Directory Structure
- **Initial_table.sql**: Creates the initial unnormalized table (`Books`) and populates it with sample data.
- **automatic_table.sql**: Automatically creates the `Books` table and populates it using data from a CSV file.
- **Normalization_forms.sql**: Implements the normalization process, transforming data into 1NF, 2NF, and 3NF.

## Features
1. **Initial Unnormalized Table**: 
   - A Books table is created with unnormalized data.
   - Data can either be inserted manually or loaded from a CSV file.

2. **Normalization Process**:
   - **1NF**: Decomposes multi-valued attributes into separate rows.
   - **2NF**: Removes partial dependencies by creating separate tables for courses and books.
   - **3NF**: Removes transitive dependencies by separating publisher information into its own table.

3. **Automated Workflow**:
   - The normalization process is fully automated using a stored procedure(normalize_table), making the workflow reusable and efficient.

4. **Verification**:
   - Joins normalized tables to verify the integrity and consistency of the transformed data against the original dataset.

## Requirements
- PostgreSQL 12 or higher
- A CSV file containing unnormalized data (Unnormalized1.csv)
- Basic understanding of SQL and database normalization principles

## Instructions to run the code
### 1: Prepare the Environment
1. Install PostgreSQL and set up a database.
2. Ensure the CSV file (`Unnormalized1.csv`) is available in the specified directory (`C:\tmp\`).
3. Open a PostgreSQL client such as pgAdmin or psql.

### 2: Execute the Scripts
#### Option 1: Manual Table Creation
1. Run Initial_table.sql to create and populate the unnormalized Books table.
2. Verify the table content with:
   sql
   SELECT * FROM Books;
#### Option 2: Automated Table Creation
1. Run automatic_table.sql to create the `Books` table and load data from the CSV file.
2. Verify the table content with:
   sql
   SELECT * FROM Books;

#### Normalization
1. Run the Normalization_forms.sql script to:
   - Drop existing normalized tables (if any).
   - Perform normalization to 1NF, 2NF, and 3NF.
   - Verify the normalized data by comparing it with the original dataset.
2. Use the CALL normalize_table(); command to execute the normalization procedure.

## Output Tables
### First Normal Form
- **first_normal_form**: Splits the multi-valued `Authors` field into separate rows.

### Second Normal Form
- **course_table_secnf**: Stores course details.
- **book_table_secnf**: Contains unique book details.
- **author_isbn**: Maps books to their respective authors.

### Third Normal Form
- **publisher_table**: Stores publisher information.
- **book_table_thirdnf**: Links books with publishers.

### Verification
- A join query ensures that normalized data matches the original unnormalized data.

## Conclusion
This project effectively demonstrates the normalization process from unnormalized data to 3 Normal Forms, showcasing the benefits of structured relational database design. The provided scripts automate the process, making them reusable for future normalization tasks.
