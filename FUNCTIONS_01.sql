select * from MPR.MEASUREMENT_POINTS a
-- The same id
join  MPR.MP_ORG_STRUCT b on a.id = b.mp_id
-- A range
where a.id between 244990 and 245000 
and
-- Subcategory
exists (select * from MPR.MEASUREMENT_POINTS a where a.alias = 2);