CREATE OR REPLACE PROCEDURE Intrudatcion
(name VARCHAR2, surname VARCHAR2, hight OUT NUMBER)
IS 
BEGIN
    dbms_output.put_line('Welcome '||name||' '||surname);
    hight:=185;
END;
/


DECLARE
    x number;

BEGIN
    x:=1;
    Intrudatcion('Mathew', 'Darlak', x);
    dbms_output.put_line('Your hight is '||x|| '.'); 
END;

/*
OUTPUT

Procedure created.

Statement processed.
Welcome Mathew Darlak
Your hight is 185.
*/