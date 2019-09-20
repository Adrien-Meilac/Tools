drop function if exists inlineMax(anyelement, anyelement);
drop function if exists inlineMin(anyelement, anyelement);

create or replace function inlineMax(anyelement, anyelement)
returns anyelement
as
$$
select case when $1 > $2 then $1 else coalesce($2, $1) end 
$$ language 'sql' volatile;

create or replace function inlineMin(anyelement, anyelement)
returns anyelement
as
$$
select case when $1 < $2 then $1 else coalesce($2, $1) end 
$$ language 'sql' volatile;
