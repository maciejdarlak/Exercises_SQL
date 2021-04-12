DECLARE
    a number;
    b number;
    c number;
    
PROCEDURE findMin(x IN number, y IN number, z OUT number) IS  //z is always the lower one, z is OUT !!!
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