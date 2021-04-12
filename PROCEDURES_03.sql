CREATE OR REPLACE PROCEDURE UpdateCourse //The goal is finding a COURSE NUMBER
   ( name_in IN varchar2 )

IS
    cnumber number;

    cursor c1 is  //cursor declaration
    SELECT course_number
    FROM courses_tbl
    WHERE course_name = name_in;

BEGIN

    open c1;
    fetch c1 into cnumber;  //the FETCH statement advances the position of the cursor through the result rows returned by the select.

    if c1%notfound then  
       cnumber := 9999;
    end if;

    INSERT INTO student_courses
    ( course_name,
      course_number )
    VALUES
    ( name_in,
      cnumber );

    commit;
 
    close c1;

EXCEPTION
WHEN OTHERS THEN
    raise_application_error(-20001,'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
END;