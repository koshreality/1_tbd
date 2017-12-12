SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE VIEW [dbo].[test_full_view] 
AS SELECT t.test_id
      ,t.name
      ,t.cert_type_id
      ,t.creation_datetime AS creation_dt
      ,tq.[order] AS question_order
      ,q.quest_id AS question_id
      ,q.name AS question_name
      ,q.creation_datetime AS question_creation_datetime
      ,q.has_description AS question_has_description
      ,qt.quest_type_id AS question_type_id
      ,qt.quest_type AS question_type_name
      ,qt.creation_datetime AS question_type_creation_dt
      ,qt.manual_grading
      ,st.sec_type_id AS section_type_id
      ,st.name  AS section_name
      ,st.has_description AS section_has_description
      ,st.creation_datetime AS section_creation_dt
      ,st.something AS section_info
      ,gc.grade_crit_id AS grading_criteria_id
      ,gc.has_description AS grading_criteria_has_description
      ,gc.creation_datetime AS grading_criteria_creation_dt
      ,gc.max_grade
      ,gc.something AS grading_criteria_info
      ,qav.answer_variant_id
      ,qav.is_right
      ,qav.creation_datetime AS answer_variant_creation_dt
      ,qav.something AS answer_variant_info
      ,a.answer_id
      ,a.something AS answer_info
      ,a.has_description AS answer_has_description
      ,a.creation_datetime AS answer_creation_dt
  FROM test t
  INNER HASH JOIN test_question tq ON t.test_id = tq.test_id
  INNER HASH JOIN question q ON tq.question_id = q.quest_id
  INNER HASH JOIN question_type qt ON q.quest_type_id = qt.quest_type_id
  INNER HASH JOIN section_type st ON qt.sec_type_id = st.sec_type_id
  INNER HASH JOIN grade_criteria gc ON qt.grade_criteria = gc.grade_crit_id
  INNER HASH JOIN question_answer_variant qav ON q.quest_id = qav.question_id
  INNER HASH JOIN answer a ON qav.answer_id = a.answer_id
GO