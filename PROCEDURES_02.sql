DECLARE
     a NUMBER ;
 
PROCEDURE squareNum(x IN OUT NUMBER) IS
    BEGIN
        x:= x * x;
    END;
    BEGIN
        a:= 100;
        squareNum(a);
        dbms_output.put_line('SquareNum of (100) is ' ||a); 
    END;
/


/*
OUTPUT
Procedure created.

Statement processed.
SquareNum of (100) is 10000
*/
