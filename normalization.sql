DROP PROCEDURE IF EXISTS normalize_books;

CREATE OR REPLACE PROCEDURE normalize_books()
LANGUAGE plpgsql
AS $$
BEGIN
    DROP TABLE IF EXISTS UnnormalizedTable, Author_ISBN, BOOK_CRN, Publisher, Course, Book CASCADE;

CREATE TABLE UnnormalizedTable (
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

    INSERT INTO UnnormalizedTable
SELECT * FROM Books;

    -- 1NF, creating Author_ISBN and BOOK_CRN
    CREATE TABLE Author_ISBN (
        "ISBN (PK2)" VARCHAR(20),
        Author VARCHAR(255),
        PRIMARY KEY ("ISBN (PK2)", Author)
    );

    INSERT INTO Author_ISBN
    SELECT DISTINCT "ISBN (PK2)", UNNEST(STRING_TO_ARRAY("Authors", ', ')) AS Author
    FROM UnnormalizedTable;

    CREATE TABLE BOOK_CRN (
        "CRN (PK1)" INT,
        "ISBN (PK2)" VARCHAR(20),
        ID SERIAL PRIMARY KEY
    );

    INSERT INTO BOOK_CRN ("CRN (PK1)", "ISBN (PK2)")
    SELECT DISTINCT "CRN (PK1)", "ISBN (PK2)"
    FROM UnnormalizedTable;

    -- 2NF, creating Publisher and Course tables
    CREATE TABLE Publisher (
        "Publisher" VARCHAR(100) PRIMARY KEY,
        "Publisher address" VARCHAR(255)
    );

    INSERT INTO Publisher
    SELECT DISTINCT "Publisher", "Publisher address"
    FROM UnnormalizedTable;

    CREATE TABLE Course (
        "CRN (PK1)" INT PRIMARY KEY,
        "Course name" VARCHAR(100)
    );

    INSERT INTO Course
    SELECT DISTINCT "CRN (PK1)", "Course name"
    FROM UnnormalizedTable;

    --3NF by creating the Book table
    CREATE TABLE Book (
        "ISBN (PK2)" VARCHAR(20) PRIMARY KEY,
        "Title" VARCHAR(255),
        "Edition" VARCHAR(100),
        "Publisher" VARCHAR(100) REFERENCES Publisher ("Publisher"),
        "Pages" INT,
        "Year" INT
    );

    INSERT INTO Book ("ISBN (PK2)", "Title", "Edition", "Publisher", "Pages", "Year")
    SELECT DISTINCT "ISBN (PK2)", "Title", "Edition", "Publisher", "Pages", "Year"
    FROM UnnormalizedTable;

    RAISE NOTICE 'Normalization completed successfully!';
END;
$$;

CALL normalize_books();
SELECT * FROM Author_ISBN;



SELECT * FROM BOOK_CRN;



SELECT * FROM Publisher;


SELECT * FROM Course;

SELECT * FROM Book;

