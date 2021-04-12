DECLARE
     a number ;
 
PROCEDURE squareNum(x IN OUT number) IS
    BEGIN
        x:= x * x;
    END;
    BEGIN
        a:= 100;
        squareNum(a);
        dbms_output.put_line('SquareNum of (100) is ' ||a); 
    END;
/