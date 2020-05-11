create or replace function array_avg(double precision[])
returns double precision AS $$
select avg(v) FROM unnest($1) g(v) where v is not null
$$ language sql;

create or replace function array_stddev(double precision[])
returns double precision AS $$
select stddev(v) FROM unnest($1) g(v) where v is not null
$$ language sql;

create or replace function array_sum(double precision[])
returns double precision AS $$
select sum(v) FROM unnest($1) g(v) where v is not null
$$ language sql;

create or replace function array_count(double precision[])
returns bigint AS $$
select count(v) FROM unnest($1) g(v)  where v is not null
$$ language sql;

create or replace function array_median(double precision[])
returns double precision AS $$
select med_median(v) FROM unnest($1) g(v) where v is not null 
$$ language sql;

create or replace function array_percentile_disc(double precision, double precision[])
returns double precision AS $$
select percentile_disc($1) within group (order by v) FROM unnest($2) g(v) where v is not null 
$$ language sql;