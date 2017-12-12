SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE VIEW [dbo].[user_full_view] 
AS SELECT u.user_id
      ,u.name
      ,u.surname
      ,u.patronymic
      ,u.date_of_birth
      ,u.nationality_region_id
      ,u.has_description AS user_has_description
      ,r.region_id 
      ,r.country
      ,r.region
      ,r.city
      ,r.town
      ,r.village
      ,r.street
      ,ur.from_date
      ,ur.to_date
      ,r1.role_id
      ,r1.name AS role_name
      ,d.dep_id AS department_id
      ,d.name AS department_name
  FROM [user] u
  INNER HASH JOIN region r ON u.nationality_region_id = r.region_id
  INNER HASH JOIN user_role ur ON u.user_id = ur.user_id
  INNER HASH JOIN role r1 ON ur.role_id = r1.role_id
  INNER HASH JOIN department d ON ur.department_id = d.dep_id
GO