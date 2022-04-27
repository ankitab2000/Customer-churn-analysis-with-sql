 create database churn_insights;
 use churn_insights;
 
 /* which is the age group for most exciting customers*/
 
 select count(*) from churn;
 
  select case when age<20 then "0-20" when age between  20 and 30 then "20 to 30"
 when age between 30 and 40 then "30 to 40" when age between 40 and 50 then "40 to 50"
 when age between 50 and 60 then "50 to 60" when age between 60 and 70 then "60 to 70"
 when age between 70 and 80 then "70 to 80" when age >80 then "above 80" end as age_range,
 count(*) as exited_cust from churn where exited=1 
 group by age_range order by exited_cust desc
 
 /* what is the avg age of customers leaving the bank*/
 select avg(age) as avg_age, exited, gender from churn
 group by exited,gender
 
 /*wether gender plays a role in attrition rate*/
 
 select gender, case when exited = 1 then "attrited" when exited=0 then "existing"
 end as status,
   count(*) from churn group by 1,2
   
   /*does the tenure plays a role  for customer attrition8*/
   
select case when tenure<2 then "0-2" when tenure between 2 and 4 then "2-4"
when tenure between 4 and 6 then "4-6" when tenure between 6 and 8 then "6-8"
when tenure between 8 and 10 then "8-10" when tenure >10 then "above 10" 
end as tenure_range,count(*) as exited_customers from churn where exited=1 
group by tenure_range order by tenure_range;

/* how is attrition effected by account balance*/
select case when  balance <25000 then "0 to 25000"
 when balance between 25000 and 75000 then "25000-75000"
 when balance between 75000 and 100000 then "75000-100000"
 when balance>100000 then "above 100000" 
 end as balance_range,case when exited=0 then 'existing'
 when exited=1 then 'attrited'end as status , 
 count(*) from churn group by balance_range,exited order by 1;
 
 /* wether having a credit card influences attrition ?*/
 select case when hascrcard=0 then 'not' 
 when hascrcard=1 then 'yes' end as crcard_status,
 case  when exited=0 then 'existing' when exited=1 then 'attrited' end as status, count(*)
from churn group by crcard_status,exited order by 2;
   
/* active members and inactive members*/
select isactivemember ,count(*) as exited_customers from churn
 group by isactivemember
 
 /*effect of credit score*/
 
 select creditscore, count(*) as count from churn
 where exited=1 group by creditscore;
  select max(creditscore) , min(creditscore) from churn;
 select case when creditscore<450 then "low"
 when creditscore between 450 and 750 then "medium"
 when creditscore between 750 and 850 then "high"
 end as creditscore_range, exited as status,count(*) from churn
 group by creditscore_range,exited order by 1
 
 /* geographical location*/
 
  select geography, exited, count(*) as exited_cust
  from churn where geography is not null 
  group by geography 
  select geography,exited , count(*)from 
  churn group by exited,geography
 /*estimated salary*/
 select case when estimatedsalary <25000 then "0-25000"
 when estimatedsalary between 25000 and 50000 then "25000-50000" 
 when estimatedsalary >50000 then "above 50000" end as salary_range,exited as status, 
 count(*) as count from churn group by salary_range,exited order by salary_range
 
 /*num of products*/
 select numofproducts,count(*) as exited from churn where exited=1  group by numofproducts
 
 select 