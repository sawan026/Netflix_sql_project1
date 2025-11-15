-- Netflix project
drop table if exists netflix ;
create table netflix 
(
show_id varchar(7)	,
type varchar(10),
title varchar(200),
director varchar(208),
casts varchar(1000),
country varchar(150) ,
date_added varchar(50),
release_year int ,
rating varchar(10),
duration varchar(15),
listed_in varchar(150)	,
description varchar(250)
)

select * from netflix;

-- 10 business problems 
1. count the number of movies and tv shows 

select
    type ,
	count(*) as total_content  
from netflix
group by type ;


2. find the most common rating for movies and tv shows 
select 
    type ,
	rating 
from 

(select type , 
    rating , 
    count(*) , 
    rank() over(partition by type order by count(*) desc) as  ranking  
from netflix 
group by type , rating ) new_table where ranking = 1;

3. list all movie released in a specific year (e.g ,2020)

select * from netflix 
where
    type = 'Movie'
	and 
	release_year = 2020;
4. list top 5 countries with the most content on netflix 

select 
    unnest(string_to_array(country, ',')) as new_country,
	count (show_id) as total_content 
from netflix
group by country
order by count(show_id) desc 
limit 5 ;

5. identify the longest movie ;

select * from netflix 
where  
    type = 'Movie'
	and 
	duration = (select max(duration) from netflix) ;

6. find content added in last 5 year 

select * from netflix 
where 
    to_date(date_added , 'month DD,yyyy') >=  current_date - interval '5 years' ;

7. find all the movie/tv shows directed by 'rajiv chilaka'!

select * from netflix 
where director ilike '%rajiv chilaka%' ;

8. list all tv shows more than 5 seasons

select 
    *
from netflix 
where 
    type = 'tv show'
	and 
	split_part(duration,' ',1) ::numeric > 5;

9. count the number of content items in each genre

select
	unnest(string_to_array(listed_In, ',')) as genre,
	count(show_id) as total_content
from netflix
group by unnest(string_to_array(listed_In, ','));


10. list all movies that are documentaries

select * from netflix 
where 
    listed_in ilike '%documentaries'























