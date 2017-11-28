SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE VIEW [dbo].[exam_full_view] 
AS SELECT r.region_id AS department_region_id
      ,r.country AS department_country
      ,r.region AS department_region
      ,r.city AS department_city
      ,d.dep_id AS department_id
      ,d.name AS department_name
      ,e.exam_id 
      ,e.test_id
      ,e.beginning
      ,e.ending
      ,e.conducted_by AS conducted_by_user_id
      ,e.something AS exam_info
      ,e.price
      ,er.request_id
      ,er.attended AS user_attended
      ,er.grade AS user_final_grade
      ,er.something AS exam_request_info
      ,er.has_description AS exam_request_has_description
      ,u.user_id
      ,u.name AS user_name
      ,u.surname
      ,u.patronymic
      ,u.date_of_birth
      ,u.nationality_region_id
      ,u.has_description AS user_has_description
      ,ua.user_answer_id
      ,ua.answer_variant_id
      ,ua.has_description AS user_answer_has_description
      ,ua.submitted_at
      ,ua.reviewed_at
      ,ua.reviewed_by AS reviewed_by_user_id
      ,ua.grade AS answer_grade
  FROM region r
  INNER HASH JOIN department d ON r.region_id = d.region_id
  INNER HASH JOIN exam e ON d.dep_id = e.dep_id
  INNER HASH JOIN exam_request er ON e.exam_id = er.exam_id
  INNER HASH JOIN [user] u ON er.user_id = u.user_id
  LEFT HASH JOIN user_answer ua ON er.request_id = ua.request_id
GO