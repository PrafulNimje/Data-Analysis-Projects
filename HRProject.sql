create database project_hr;

#KPI-1 Average Attrition rate for all Departments
with e as (
select department ,
count((case Attrition when "No" then Attrition end)) as
No_Attrition ,
count((case Attrition when "Yes" then Attrition end)) as
Yes_Attrition ,
count((case when Attrition="Yes" or Attrition="No" then Attrition end )) as SumOFAttrition
from hr1 group by department) select * , concat(round(Yes_Attrition/SumOFAttrition,2)*100,"%") as Average_Attirition_Rate from e;


#KPI-2 Average Hourly rate of Male Research Scientist
select gender,avg(HourlyRate) as 'Average Hourly Rate'
from hr1
where Gender = 'male' and JobRole ='Research Scientist';

#KPI-3 Attrition rate Vs Monthly income stats
select * from project_hr.hr2;
alter table hr2
add income int;
update project_hr.hr2
set income = case
when MonthlyIncome <5001 then 5000
when MonthlyIncome <10001 then 10000
when MonthlyIncome <15001 then 15000
when MonthlyIncome <20001 then 20000
when MonthlyIncome <25001 then 25000
when MonthlyIncome <30001 then 30000
when MonthlyIncome <35001 then 35000
when MonthlyIncome <40001 then 40000
when MonthlyIncome <45001 then 45000
else 50000
end;

with e as (
select department ,income,
count((case Attrition when "No" then Attrition end)) as
No_Attrition ,
count((case Attrition when "Yes" then Attrition end)) as
Yes_Attrition ,
count((case when Attrition="Yes" or Attrition="No" then Attrition end )) as SumOFAttrition
from hr1 h1 inner join hr2 h2
on h1.EmployeeNumber = h2.EmployeeID
group by income) select * , concat(round(Yes_Attrition/SumOFAttrition,2)*100,"%") as Average_Attirition_Rate from e;

#KPI-4 Average working years for each Department
select department, Avg(TotalWorkingYears) as 'Average Woring Years'
from hr1 h1 inner join hr2 h2
on h1.EmployeeNumber = h2.EmployeeID
group by department;

#KPI-5 Job Role Vs Work life balance
select JobRole,WorkLifeBalance ,count(WorkLifeBalance) as 'NewCount'
from hr1 h1 inner join hr2 h2
on h1.EmployeeNumber = h2.EmployeeID
group by JobRole, WorkLifeBalance
order by WorkLifeBalance asc;

#KPI-6 Attrition rate Vs Year since last promotion relation
with e as (
select department ,YearsSinceLastPromotion,
count((case Attrition when "No" then Attrition end)) as
No_Attrition ,
count((case Attrition when "Yes" then Attrition end)) as
Yes_Attrition ,
count((case when Attrition="Yes" or Attrition="No" then Attrition end )) as SumOFAttrition
from hr1 h1 inner join hr2 h2
on h1.EmployeeNumber = h2.EmployeeID
group by department,YearsSinceLastPromotion) select * , concat(round(Yes_Attrition/SumOFAttrition,2)*100,"%") as Average_Attirition_Rate from e
order by department;