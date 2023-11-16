SELECT abs.ID,
re.Reason,
abs.Month_of_absence,
abs.Body_mass_index,
CASE WHEN abs.Month_of_absence IN (12,1,2) THEN 'Winter'
	WHEN abs.Month_of_absence IN (3,4,5) THEN 'Spring'
	WHEN abs.Month_of_absence IN (6,7,8) THEN 'Summer'
	WHEN abs.Month_of_absence IN (9,10,11) THEN 'Autumn'
	ELSE 'Unknown' END AS Season,
CASE WHEN abs.Body_mass_index < 18.5 THEN 'Underweight'
	WHEN abs.Body_mass_index BETWEEN 18.5 AND 25 THEN 'Healthy'
	WHEN abs.Body_mass_index BETWEEN 25 AND 30 THEN 'Overweight'
	ELSE 'Obese' END AS BMI_Category,
abs.Seasons,
abs.Month_of_absence,
abs.Day_of_the_week,
abs.Transportation_expense,
abs.Education,
abs.Son,
abs.Social_drinker,
abs.Social_smoker,
abs.Pet,
abs.Disciplinary_failure,
abs.Age,
abs.Work_load_Average_day,
abs.Absenteeism_time_in_hours
FROM Absenteeism_at_work abs
JOIN Reasons re
ON abs.Reason_for_absence = re.Number
JOIN compensation com
ON abs.ID = com.ID;

---List of healthy individuals and low absenteeism for the healthy bonus group
SELECT social_drinker, social_smoker, body_mass_index
FROM Absenteeism_at_work
WHERE Social_drinker = 0 AND Social_smoker = 0 AND Body_mass_index > 25
--- We consider individuals with more than a bmi of 25 and those who don't smoke nor drink
AND Absenteeism_time_in_hours < (select AVG(Absenteeism_time_in_hours) FROM Absenteeism_at_work)

---Total number of non smokers
SELECT COUNT(*) AS total_non_smokers
FROM Absenteeism_at_work
WHERE Social_smoker = 0;

-- Compensation budget of $983,221
-- For an employee working 40 hrs a week for 52 weeks a year. 
-- For a total of 686 employees each get 1,433.27 compensation in an year
