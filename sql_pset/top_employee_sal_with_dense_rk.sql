select BusinessEntityID, count(*)
from 
group by BusinessEntityID
having count(*) > 1



/*
* Question: Find the top 3 salaries from Employee table using Rank Function.
* Solution: We will be using Dense_rank() as we need consecutive rank even for same values.
* The Rank() function will skip over consective rank for smatching salaries.
*/
select *
from (
	select E.BusinessEntityID	, FirstName, LastName, JobTitle, emp_pay_rate.Rate, emp_pay_rate.PayFrequency, total_pay,
	DENSE_RANK() OVER (order by total_pay desc) salary_rank
	from [Person].[Person] P
	inner join [HumanResources].[Employee] E on P.BusinessEntityID = E.BusinessEntityID
	inner join (
		select *, Rate*PayFrequency total_pay
		from(
			select *, 
			ROW_NUMBER() OVER (Partition by BusinessEntityID order by RateChangeDate desc) r_num
			from [HumanResources].[EmployeePayHistory]
		)recent_emp_pay
		where r_num=1 
	)emp_pay_rate on P.BusinessEntityID = emp_pay_rate.BusinessEntityID
)final_t
where salary_rank <=3