DECLARE
    a NUMBER;
    b NUMBER;
    c NUMBER;
    
PROCEDURE findMin(x IN NUMBER, y IN NUMBER, z OUT NUMBER) IS  /*z is always the lower one, z is OUT*/
    BEGIN
        IF  x < y THEN
            z:= x;
        ELSE
            z:= y;
        END IF;
    END;
    BEGIN
        a:= 10;
        b:= 20;
        findMin(a, b, c);
        dbms_output.put_line('Minimum value of (10, 20) is ' || c);
    END;
/


/*
OUTPUT
Procedure created.

Statement processed.
Minimum value of (10, 20) is 10
*/