CREATE OR REPLACE PROCEDURE UpdateCourse /* The goal is finding a COURSE NUMBER*/
   ( name_in IN VARCHAR2 ) IS

  cnumber NUMBER;

  CURSOR c1  /* Cursor declaration - it finds the course nr's*/
  IS
  SELECT course_number
  FROM courses_tbl
  WHERE course_name = name_in;

  BEGIN /* 3 steps - open, fetch and close - all is taken from cursor*/
    OPEN c1;
    FETCH c1 INTO cnumber;  /* The FETCH statement advances the position of the cursor through the result rows returned by the select and get them*/
      IF c1%notfound THEN  
         cnumber := 9999;
      END IF;
      INSERT INTO student_courses
        ( course_name,
          course_number )
      VALUES
        ( name_in,
          cnumber );
      COMMIT;
    CLOSE c1;

    EXCEPTION
      WHEN OTHERS THEN
        raise_application_error(-20001,'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
  END;