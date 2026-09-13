USE customer_support_analytics;

-- ============================================================
-- CUSTOMER SUPPORT & SERVICE ANALYTICS
-- Business Analysis Queries
-- ============================================================
-- Q1: Which support category receives the highest number of tickets?

SELECT
    category,
    COUNT(ticket_id) AS ticket_count
FROM tickets
GROUP BY category
ORDER BY ticket_count DESC;

-- Q2 — Which support agents handle the most tickets?

select a.agent_name , count(t.ticket_id) as ticket_count 
from agents a  join tickets t on
t.agent_id = a.agent_id 
group by a.agent_name
order by ticket_count desc;

-- Q3 — Which support agents have the highest number of resolved tickets?

select a.agent_name , count(ticket_id ) as response_count from agents a 
join tickets t  on  t.agent_id  =  a.agent_id 
where status = 'Resolved'
group by a.agent_name order by response_count desc
 ; 
 -- Q4 What percentage of all tickets are resolved?
 
 with com as (
 select count(ticket_id ) as total_tickets ,
 (select count(ticket_id)  from tickets where status = 'Resolved')
 as  resolved_ticketsfrom from tickets )

select (resolved_tickets / total_tickets) * 100
 as tickets_percentage from com;         

--  Q5 What is the average number of days it takes to resolve a ticket?


select avg(DATEDIFF( resolved_date , created_date))
  as average_resolution_time from tickets
  where status = 'Resolved' ;
 
-- Q6 — Which support category has the longest average resolution time?

select category , 
      avg(DATEDIFF( resolved_date , created_date)) 
      as  average_resolution_time
      from tickets where status = 'Resolved'
      group by category 
      order by average_resolution_time desc ;
      
 -- Q7 — Which customers have submitted the most tickets?
 
 select c.customer_name , count(t.ticket_id)
 as ticket_count from customers c join tickets t on 
 t.customer_id  = c.customer_id 
 group by c.customer_name,c.customer_id order by ticket_count desc ;
      
-- Q8 — Which customers have the most unresolved tickets?

  select c.customer_name , count(t.ticket_id)
 as unsolve_ticket_count from customers c join tickets t on 
 t.customer_id  = c.customer_id 
 where status = 'open'
 group by c.customer_name,c.customer_id order by unsolve_ticket_count desc ;
 
 -- Q9 — Which support priority has the most tickets?
 
 select priority, count(ticket_id ) as ticket_count from tickets 
 group by priority order by ticket_count desc ;
 
 -- Q10 — What is the average response time by response type?
 
 select response_type , avg(response_time_min ) 
 as average_response_time from responses
 group by response_type order by average_response_time desc ; 
 
 -- Q11 — Which agent has the fastest average response time?
 
 select a.agent_name , avg(r.response_time_min ) 
 as average_response_time from agents a inner join tickets t on
 t.agent_id = a.agent_id  inner join responses r on 
 r.ticket_id = t.ticket_id 
 group by a.agent_name order by average_response_time asc;
 
 -- Q12 — Which department handles the most tickets?
 
 select a.department , count(t.ticket_id )as ticket_count
 from agents a join tickets t on 
 t.agent_id = a.agent_id  group by  a.department 
 order by ticket_count desc;
                      
-- Q13 — Which department has the highest average response time?


select a.department , avg(r.response_time_min ) 
 as average_response_time from agents a inner join tickets t on
 t.agent_id = a.agent_id  inner join responses r on 
 r.ticket_id = t.ticket_id 
 group by a.department order by average_response_time desc;     
 
 -- Q14 — Which ticket priority has the highest average response time?
 
 select t.priority , avg(r.response_time_min) 
 as response_time from tickets t inner join responses r on 
 r.ticket_id = t.ticket_id group by t.priority 
 order by response_time desc;
 
 -- Q15 Which support agent has the highest average customer rating?
 
	select a.agent_name , avg(f.rating) 
    as average_rating from agents a join tickets t  on 
    t.agent_id  = a.agent_id join feedback f on 
    f.ticket_id = t.ticket_id 
    group by a.agent_name order by average_rating desc;
    
-- Q16 Which support category has the highest average customer rating?
    
select t.category , avg(f.rating) as average_rating 
from tickets t join feedback f  on 
f.ticket_id = t.ticket_id 
group by t.category order by average_rating desc;    
 
 -- Q17 Which support agent has the highest average resolution time?
 
 select a.agent_name , avg(datediff(resolved_date , created_date ) )
 as average_response_time from agents a join tickets t on
 t.agent_id = a.agent_id 
 where t.status = 'Resolved' 
 group by a.agent_name order by average_response_time desc;
 
 -- Q18 Which support agent has both a high
 -- average rating (≥ 4) AND at least 2 resolved tickets?
 
 select a.agent_name , avg(f.rating) as average_rating , 
 count(t.ticket_id) as ticket_count from agents a join tickets t on 
 t.agent_id = a.agent_id join feedback f on 
 f.ticket_id = t.ticket_id 
 where t.status = 'Resolved'
 group by a.agent_name having
 average_rating >= 4 and ticket_count >= 2 
 order by average_rating desc, ticket_count desc;
 
 -- Q19 Which customers have submitted more than
 -- 1 ticket and have at least 1 unresolved ticket?
 
 select c.customer_name , count(t.ticket_id ) as  ticket_count ,
 count(case when t.status = 'Open' then 1 end ) as unresolved_tickets 
 from customers c join tickets t on 
 t.customer_id = c.customer_id 
 group by c.customer_name 
  having ticket_count > 1 
  and unresolved_tickets >= 1;
  
  -- Q20 Which customers have an average ticket 
  -- rating higher than the overall average rating?
  
  with com as (
  select c.customer_name , avg(f.rating) as average_rating
       from customers c 
       join  tickets t on t.customer_id = c.customer_id 
       join feedback f on f.ticket_id = t.ticket_id group by customer_name
      )
       
select * , avg(average_rating) over() as overall_average_rating,
(average_rating - avg(average_rating) over()) as difference
from com;      
       
-- Q21 — Which support category has both below-average 
-- customer satisfaction and above-average resolution time? 

with com as(
select t.category , avg(f.rating) as average_rating ,
avg(datediff(resolved_date , created_date))  as average_resolution_time
 from tickets t join feedback f on f.ticket_id = t.ticket_id 
group by t.category ) ,

second_query as (
select *, avg(average_rating) over() as overall_average_rating ,
         avg(average_resolution_time) over() as overall_average_resolution_time
         from com)
         
         select * from second_query
         where overall_average_rating > average_rating and 
               overall_average_resolution_time < average_resolution_time;
              
         
 --  Q22 Which agents have a higher average customer
 -- rating than the average rating of their department?  
 
with com as(
 select a.agent_name , a.department , 
 avg(f.rating) as agent_average_rating from agents a 
 join tickets t on t.agent_id = a.agent_id 
 join feedback f on f.ticket_id = t.ticket_id 
 group by a.agent_name , a.department) ,
 
 second_query as (
 select *,  
 avg(agent_average_rating) over(partition by department) department_average_rating 
 from com ) 
 
 select * from second_query where agent_average_rating > department_average_rating ;
 
 -- Q23 Which agents handle more tickets than the average
  -- number of tickets handled by agents in their department?
  
  with com as ( 
  select a.agent_name, a.department , 
  count(t.ticket_id ) as  total_ticket_handle 
  from agents a join tickets t on
  t.agent_id = a.agent_id 
  group by a.agent_name , a.department),
 
 second_query as (
select*, avg(total_ticket_handle ) 
over(partition by department) as department_average
 from com)
 
 select * from second_query 
 where department_average < total_ticket_handle;
 
-- Q24 Which support agents have the highest resolution rate?

with com as (
select a.agent_name , count(t.ticket_id ) as total_ticket ,
     count(case when t.status = 'Resolved' then 1 end ) as resolved_tickets 
     from agents a  join tickets t on 
     t.agent_id = a.agent_id 
     group by a.agent_name) 
     
select * , (resolved_tickets / total_ticket) * 100 as resolution_rate from com
order by resolution_rate desc ;

-- Q25 Which agents have a higher resolution rate
--  than the average resolution rate of their department?

with com as (
select a.agent_name , a.department,
 count(t.ticket_id ) as total_tickets ,
     count(case when status = 'Resolved' then 1 end ) as resolved_tickets ,
     (count(case when status = 'Resolved' then 1 end ) /  count(t.ticket_id ) ) 
     * 100 as agent_average_resolution_rate  
     from agents a join tickets t on 
     t.agent_id = a.agent_Id
     group by a.agent_name, a.department),
    
    second_query as (
     select * ,
     avg(agent_average_resolution_rate) over(partition by department )
     as department_average_resolution_rate
     from com)
     
     select * from second_query
     where agent_average_resolution_rate > department_average_resolution_rate;
     
-- Q26 Which support categories have a resolution rate below the overall resolution rate?

with com as (
select category , count(ticket_id ) as total_tickets,
      count(case when status = 'Resolved' then 1 end) as resolved_tickets ,
      (count(case when status = 'Resolved' then 1 end) / count(ticket_id )) * 100 
     as resolution_rate from tickets group by category) ,
 second_query as (
select * , SUM(resolved_tickets) OVER(),
SUM(total_tickets) OVER() ,
(SUM(resolved_tickets) OVER()
 / SUM(total_tickets) OVER()) * 100 as overall_resolution_rate 
from com
 )
 select category , total_tickets , resolved_tickets ,
       resolution_rate , overall_resolution_rate from second_query  
       where resolution_rate < overall_resolution_rate;
       
--  Q27 Which support categories have an average customer
--  rating below the overall average customer rating?

with com as (
select t.category  , 
      avg(f.rating) as average_rating from tickets t
      join feedback f on f.ticket_id = t.ticket_id 
      group by category ),
    
second_query as (    
 select * ,avg(average_rating) over() 
          as overall_average_rating from com )
   
   select *  from second_query 
   where average_rating < overall_average_rating;
   
   -- Q28 Rank all support agents by their resolution rate, highest to lowest.
   
   with com as (
   select a.agent_name , count(t.ticket_id ) as total_tickets,
        count(case when status = 'Resolved' then 1 end) as resolved_tickets ,
        (count(case when status = 'Resolved' then 1 end)/
          count(t.ticket_id ) ) *100 as resolution_rate from agents a 
          join tickets t on t.agent_id = a.agent_id 
          group by a.agent_name)
 
 select * , rank() over (order by resolution_rate desc)
 as resolution_rank from com;
       

 -- Q29 Rank support categories by their average
 -- resolution time, from longest to shortest.
  
with  com as (
select category , 
avg(datediff(resolved_date , created_date)) as average_resolution_time 
from tickets
where status = 'Resolved' group by category )

select *, rank() over(order by average_resolution_time  desc) 
  as resolution_rank from com ;
  
-- Q30 Which support agent has the best overall performance, 
-- considering BOTH resolution rate and customer satisfaction?

with com as (
select a.agent_name,   count(t.ticket_id ) as total_tickets ,
	count( case when  status = 'Resolved' then 1 end) as resolved_tickets,
    (count( case when  status = 'Resolved' then 1 end) /
      count(t.ticket_id ) ) * 100 as resolution_rate ,
      avg(f.rating) as average_rating    from agents a 
      join tickets t on t.agent_id = a.agent_id 
      join feedback f on f.ticket_id = t.ticket_id 
      group by a.agent_name ) 
      
select * ,resolution_rate  + ( average_rating * 20 )
        as performance_score from com 
        order by performance_score desc;
      
      
      
    
     
     
  



      
