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

INSERT INTO Books ("CRN (PK1)", "ISBN (PK2)", "Title", "Authors", "Edition", "Publisher", "Publisher address", "Pages", "Year", "Course name")
VALUES 
(20424, '133970779', 'Fundamentals of Database Systems 7th Edition', 'Ramez Elmasri, Shamkant Navathe', '7', 'Pearson', '1 Lake Street Upper Saddle River, NJ 07458 United States', 1280, 2018, 'Introduction to DB Systems'),
(20424, '1111969604', 'Database Systems: Design, Implementation, and Management', 'Carlos Coronel, Steven Morris, Peter Rob', '10', 'Course Technology', '5 Maxwell Drive, Clifton Park NY 12065, Boston, MA, United States', 752, 2019, 'Introduction to DB Systems'),
(20424, '135188148', 'Database Concepts', 'David Kroenke, David Auer, Scott Vandenberg, Robert Y', '9', 'Pearson', '1 Lake Street Upper Saddle River, NJ 07458 United States', 552, 2019, 'Introduction to DB Systems'),
(10122, '133970779', 'Fundamentals of Database Systems 7th Edition', 'Ramez Elmasri, Shamkant Navathe', '7', 'Pearson', '1 Lake Street Upper Saddle River, NJ 07458 United States', 1280, 2018, 'Big Data and Analytics'),
(20451, '1119803780', 'Systems Analysis and Design', 'Alan Dennis, Barbara Wixom, Roberta M. Roth', '7', 'Wiley', '111 River Street, Hoboken, NJ, USA', 464, 2021, 'Systems Analysis & Design'),
(31311, '908606273', 'My Cat Likes to Hide in Boxes', 'Lynley Dodd', '1', 'Mallinson Rendel', '5th Flr, 15 Courtenay Place Te Aro, Wellington, New Zealand', 345, 2013, 'Academic Writing'),
(10209, '131103627', 'C Programming Language', 'Brian W. Kernighan, Dennis M. Ritchie', '2', 'Pearson', '1 Lake Street Upper Saddle River, NJ 07458 United States', 272, 1988, 'Programming Principles I'),
(10209, '1718501048', 'Effective C: An Introduction to Professional C Programming', 'Robert C. Seacord', '2', 'No Starch Press', '329 Primrose Road, #42 Burlingame, CA 94010-4093 USA', 272, 2020, 'Programming Principles I');

SELECT * FROM Books;
