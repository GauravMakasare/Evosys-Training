--
--   INDEX 
--    - database objects that are used to retrive data quickly from the database 
--    - indexes are used to increase query performance 
--    - indexes are generally created on the columns of the tables 
-- ________________________________________________________________________________
--    - Indexes are created in 2 ways 
--      - automatically 
--                 -  whenever in the table theres a primary key or a unique key then the oracle server automatically creates a Btree index on those columns 
--      - manually
--           they include 
--                        - Btree indexes
--                        - Bitmap indexes
--                        - Function based index 
--                        - Unique Index
-- ________________________________________________________________________________

--SYNTAX TO CREATE INDEX
--CREATE INDEX 
--    index_name 
--ON 
--    table_name(column1[,column2,...])
-- ________________________________________________________________________________

--CREATING INDEX ONTO A COL IN A TABLE 

CREATE INDEX
        members_email_i
ON
        members(email);
        
-- ________________________________________________________________________________        
--DISPLAYING THE INDEXES CREATED ON A TABLE

SELECT 
    index_name, 
    index_type, 
    visibility, 
    status 
FROM 
    all_indexes
WHERE 
    table_name = 'MEMBERS';

-- ________________________________________________________________________________   
--Removing an index
--To remove an index, you use the DROP INDEX statement:
--DROP INDEX 
--           index_name;
-- ________________________________________________________________________________   

-- CREATING INDEX ON MULTIPLE COLUMNS OF THRE TABLE 

CREATE INDEX 
        members_name_i
ON 
        members(last_name,first_name);
 -- ________________________________________________________________________________          
        
SELECT 
    index_name, 
    index_type, 
    visibility, 
    status 
FROM 
    all_indexes
WHERE 
    table_name = 'MEMBERS';
    
 -- ________________________________________________________________________________      
 
--Oracle UNIQUE index
--An index can be unique or non-unique.
--A unique index ensures that no two rows of a table have duplicate values in the indexed column (or columns). 
--A non-unique index does not impose this restriction on the indexed column’s values.
--
--CREATE UNIQUE INDEX  SYNTAX
--
--CREATE UNIQUE INDEX 
--    index_name 
--ON 
--    table_name(column1[,column2,...]);