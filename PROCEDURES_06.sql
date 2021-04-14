create or replace function desiredCountry
(countryName out varchar2)
return varchar2
is
cword varchar2;

-- cursor gets a particular country
cursor c1 is
select country
from WORLD."WORLD_POPULATION" 
where country = countryName;

-- cword = cursor
begin
    open c1;
    fetch c1 into cword;
    close c1;
    return cword;
end;




declare 
x varchar2 :='Croatia';

-- using function
begin
    desiredCountry(x);
    dbms_putline.put_line(x);
end;