CREATE TABLE Books (
    "CRN (PK1)" INT,
    "ISBN (PK2)" VARCHAR(20),
    "Title" VARCHAR(255),
    "Authors" VARCHAR(255),
    "Edition" VARCHAR(100),
    "Publisher" VARCHAR(100),
    "Publisher address" VARCHAR(255),
    "Pages" INT,
    "Year" INT,
    "Course name" VARCHAR(100)
);

\copy Books ("CRN (PK1)", "ISBN (PK2)", "Title", "Authors", "Edition", "Publisher", "Publisher address", "Pages", "Year", "Course name")
FROM 'C:\Users\Acer\Desktop\Unnormalized1.csv'
DELIMITER ',' 
CSV HEADER;

SELECT * FROM Books;
