drop aggregate if exists med_median(double precision);
drop function if exists tmedian(double precision[]);

create function tmedian(double precision[])
returns double precision as $$
select avg(val) 
from 
(
    select val
    from unnest($1) val
    order by 1
    LIMIT  2 - mod(array_upper($1, 1), 2)
    OFFSET ceil(array_upper($1, 1) / 2.0) - 1
   ) "sub";
$$ language 'sql' volatile;
 
create aggregate med_median(double precision) 
(
 sfunc = array_append,
 stype = double precision[],
 finalfunc  = tmedian,
 initcond = '{}'
);