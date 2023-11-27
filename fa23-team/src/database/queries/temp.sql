SELECT legal_business_name, city, "state", total_obligation 
FROM rpt.recipient_lookup
INNER JOIN (select recipient_hash, sum(total_obligation) as total_obligation  
	from rpt.award_search 
	where naics_code = '541611'
	and period_of_performance_start_date between '2000-01-01' and '2024-01-01'
	group by recipient_hash
) as totals
on rpt.recipient_lookup.recipient_hash = totals.recipient_hash
order by total_obligation DESC;