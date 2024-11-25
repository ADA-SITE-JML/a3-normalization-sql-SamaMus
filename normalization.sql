DROP TABLE IF EXISTS unnormalized_data CASCADE;
DROP TABLE IF EXISTS first_normal_form CASCADE;
DROP TABLE IF EXISTS course_table_secnf CASCADE;
DROP TABLE IF EXISTS book_table_secnf CASCADE;
DROP TABLE IF EXISTS author_isbn CASCADE;
DROP TABLE IF EXISTS course_table_thirdnf CASCADE;
DROP TABLE IF EXISTS publisher_table CASCADE;
DROP TABLE IF EXISTS book_table_thirdnf CASCADE;

CREATE OR REPLACE PROCEDURE normalize_table()
LANGUAGE plpgsql
AS $$
DECLARE
    result RECORD;
BEGIN
    DROP TABLE IF EXISTS unnormalized_data CASCADE;

    CREATE TABLE unnormalized_data (
        CRN INTEGER,
        ISBN BIGINT,
        Title TEXT,
        Authors TEXT,
        Edition INTEGER,
        Publisher TEXT,
        PublisherAddress TEXT,
        Pages INTEGER,
        Year INTEGER,
        CourseName TEXT,
        PRIMARY KEY (CRN, ISBN)
    );

    -- Import data from CSV
    COPY unnormalized_data (CRN, ISBN, Title, Authors, Edition, Publisher, PublisherAddress, Pages, Year, CourseName)
    FROM 'C:\tmp\Unnormalized1.csv'
    DELIMITER ',' 
    CSV HEADER ENCODING 'UTF8';

    -- 1NF
    CREATE TABLE first_normal_form  (
        CRN INTEGER,
        ISBN BIGINT,
        Title TEXT,
        Author TEXT,
        Edition INTEGER,
        Publisher TEXT,
        PublisherAddress TEXT,
        Pages INTEGER,
        Year INTEGER,
        CourseName TEXT
    );

    INSERT INTO first_normal_form  (CRN, ISBN, Title, Author, Edition, Publisher, PublisherAddress, Pages, Year, CourseName)
    SELECT 
        CRN,
        ISBN,
        Title,
        UNNEST(STRING_TO_ARRAY(TRIM(BOTH ' ' FROM REGEXP_REPLACE(Authors, '\s+', ' ', 'g')), ', ')) AS Author,
        Edition,
        Publisher,
        PublisherAddress,
        Pages,
        Year,
        CourseName
    FROM unnormalized_data;

    -- 2NF
    CREATE TABLE course_table_secnf (
        CRN INTEGER PRIMARY KEY,
        CourseName TEXT
    );

    INSERT INTO course_table_secnf (CRN, CourseName)
    SELECT DISTINCT CRN, CourseName
    FROM first_normal_form ;

    CREATE TABLE  book_table_secnf (
        ISBN BIGINT PRIMARY KEY,
        Title TEXT,
        Edition INTEGER,
        Publisher TEXT,
        PublisherAddress TEXT,
        Pages INTEGER,
        Year INTEGER
    );

    INSERT INTO  book_table_secnf (ISBN, Title, Edition, Publisher, PublisherAddress, Pages, Year)
    SELECT DISTINCT ISBN, Title, Edition, Publisher, PublisherAddress, Pages, Year
    FROM first_normal_form ;

    CREATE TABLE author_isbn (
        ISBN BIGINT,
        Author TEXT,
        FOREIGN KEY (ISBN) REFERENCES  book_table_secnf(ISBN)
    );

    INSERT INTO author_isbn (ISBN, Author)
    SELECT DISTINCT ISBN, Author
    FROM first_normal_form ;

    CREATE TABLE course_table_thirdnf (
        CRN INTEGER,
        ISBN BIGINT,
        PRIMARY KEY (CRN, ISBN),
        FOREIGN KEY (CRN) REFERENCES course_table_secnf(CRN),
        FOREIGN KEY (ISBN) REFERENCES  book_table_secnf(ISBN)
    );

    INSERT INTO course_table_thirdnf (CRN, ISBN)
    SELECT DISTINCT CRN, ISBN
    FROM first_normal_form ;

    -- 3NF
    CREATE TABLE publisher_table (
        Publisher TEXT PRIMARY KEY,
        PublisherAddress TEXT
    );

    INSERT INTO publisher_table (Publisher, PublisherAddress)
    SELECT DISTINCT Publisher, PublisherAddress
    FROM  book_table_secnf;

    CREATE TABLE book_table_thirdnf (
        ISBN BIGINT PRIMARY KEY,
        Title TEXT,
        Edition INTEGER,
        Publisher TEXT,
        Pages INTEGER,
        Year INTEGER,
        FOREIGN KEY (Publisher) REFERENCES publisher_table(Publisher)
    );

    INSERT INTO book_table_thirdnf (ISBN, Title, Edition, Publisher, Pages, Year)
    SELECT DISTINCT ISBN, Title, Edition, Publisher, Pages, Year
    FROM  book_table_secnf;

    RAISE NOTICE 'Normalization process completed successfully!';
END;
$$;

CALL normalize_books();
