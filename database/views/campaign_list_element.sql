create view campaign_list as
select
  c.id,
  c.name,
  c.primary,
  c.platform,
  c.campaign_status,
  c.time,
  c.open,
  c.campaign_link,
  c.description,
  c.image,
  m.missions,
  r.reports
from campaign c,
  (
    select
      campaign_id,
      count(campaign_id) missions
    from mission
    group by campaign_id
  ) m,
  (
    select
      campaign_id,
      count(report.mission_id) reports
    from mission, report
    where mission.id = report.mission_id
    group by campaign_id
  ) r
where m.campaign_id = c.id and c.id = r.campaign_id;