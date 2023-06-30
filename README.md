# Bellabeat-Capstone: Case Study

Author: Vanessa Dailey

Date: June 29, 2023

![bruce-mars-ZXq7xoo98b0-unsplash](https://github.com/vanessadailey/Bellabeat-Capstone/assets/125935435/8960bf39-c64d-45d1-be54-787721aa6151)

## Introduction
In the Bellabeat Case Study 2 for the Capstone Project, I assume the role of a junior data analyst on the Bellabeat marketing analyst team. I'm working with Bellabeat, a well-known producer of health-oriented products for women.

I used the six-step data analysis approach outlined in the Google Data Analytics Professional Certificate course: Ask, Prepare, Process, Analyze, Share, and Act in order to address the pertinent questions. These phases led me through the entire project and provided a structured method for answering the business questions.

## About Bellabeat
Bellabeat is a high-tech firm founded by Urška Sršen and Sando Mur. It focuses in developing women's smart products with a health focus. Bellabeat empowers women by offering information about numerous areas of their health, such as exercise, sleep, stress, and reproductive health, using exceptionally developed technology. Bellabeat has swiftly expanded since its founding in 2013 to become a well-known tech-driven wellness brand.

In addition to their own online store on their website, Bellabeat items are also sold through an increasing number of other online merchants.

## The Scenario
As a junior data analyst in the Bellabeat marketing team, I will be evaluating smart device data for one of the smart device products. I'll provide our marketing plan strategic direction by identifying customer usage trends. Bellabeat is a prosperous small business looking for new prospects. 

It has the ability to expand in the worldwide market for smart devices. Urška Sršen, co-founder and chief creative officer, thinks that delving into fitness data from smart gadgets might open these doors. I'll provide my results and high-level suggestions to the Bellabeat leadership team, which shapes our marketing strategy accordingly.

## 1 → Ask
### Business Task
Applying consumer usage data from non-Bellabeat smart devices, which we use FitBit data here, to comparable Bellabeat products like the Bellabeat Leaf will provide insight into how people utilize their smart gadgets.

### Key stakeholders
 Urška Sršen: Bellabeat's cofounder and Chief Creative Officer
Sando Mur: Mathematician and Bellabeat's cofounder; key member of the Bellabeat executive team
Bellabeat marketing analytics team: A team of data analysts responsible for gathering, evaluating, and reporting data to assist steering Bellabeat's marketing strategy.

### Questions to guide analysis:
- What are some trends in smart device usage?
- How could these trends apply to Bellabeat customers?
- How could these trends help influence Bellabeat marketing strategy?

## 2 → Prepare
### About the data
- The data is freely available on Kaggle as FitBit Fitness Tracker Data and is saved in 18 csv files.
- 33 FitBit users who qualified volunteered to provide their personal tracking information, which included minute-level output for heart rate, sleep, and physical activity monitoring. It contains information on steps taken each day, heart rate, and daily activities that may be investigated to find out more about users' habits. 
- Participants in a distributed survey that was carried out using Amazon Mechanical Turk first developed the dataset. 
- The survey was performed during a 30-day period from 04–12–2016 to 05–12–2016.

### Limitations of the data
- Out of the 31 million active users and 111 million registered users of FitBit, only 33 people were evaluated, so the data is most likely not representative of all FitBit users. As a result, the margin of error at a 90% or 95% confidence level is 15% or 18%, which is higher than the acceptable margin of error employed by the majority of survey researchers, which is normally between 4% and 8%. According to the Central Limit Theorem (CLT), the smallest sample size for which the CLT remains valid is 30, so although this is not ideal it's still relevant.
- The data originates from a third-party source, Amazon Mechanical Turk survey, and there is no way to check for credibility or any biases.
- Only 21% of participants logged heart-rate data, 24% for weight logging data and 72% for sleep data, so there is missing data for each of these files since participants weren't asked to wear their FitBit for the entire 30-day period. There's also no data on sex, age, height, race, etc., which would be helpful since Bellabeat is specifically based on women's health.
- The information is outdated. Since 2016, additional products and features have been released by FitBit and Bellabeat, respectively. Like the gadgets themselves, smart device usage has probably evolved since then.

*Final thoughts:* The dataset is generally regarded as having low quality data, and it is not advised to build business suggestions on this data.

## 3 → Process
### Cleaning the data

![scott-graham-5fNmWej4tAA-unsplash](https://github.com/vanessadailey/Bellabeat-Capstone/assets/125935435/4490d4bc-e11f-4b85-b410-00aea3bd9644)

**Renamed the csv files to:**
 → Daily_Activity_Merged
 → Hourly_Intensity_Merged
 → Hourly_Steps_Merged
 → Daily_Sleep_Merged
 → Hourly_Calories_Merged
 → Heart_Rate_Merged
 → Weight_Log_Merged
 
**Using Excel**
- To determine the number of unique users in the dataset, data was sorted and filtered by Id. Then counted how many digits were in each data number, which came out to be 10, to make sure they were all consistent.
- 3 duplicates were found in the Daily_Sleep_Merged file after following the steps of highlighting all cells > Data > Remove Duplicates. 
- Formatted date data into MM/DD/YY date format and if time was configured with date such as in the Daily_Sleep_Merged table then I separated them into two columns (Date & Time). 
- Presented all numerical data in Number format, either with no decimal places or up to two.

## 4 - 5 → Analyze & Share
**Using Bigquery Sandbox/SQL, I uploaded these files and renamed them:**
- Daily_Activity_Merged → **Daily_Activity**
- Hourly_Intensity_Merged → **Hourly_Intensity**
- Hourly_Steps_Merged → **Hourly_Steps**
- Daily_Sleep_Merged → **Sleep_Day**
- Hourly_Calories_Merged → **Hourly_Calories**
- Heart_Rate_Merged → **Heartrate_Seconds**
- Weight_Log_Merged → **Weight_Log**

**After uploading:**
![Screenshot 2023-06-29 at 6 40 21 PM](https://github.com/vanessadailey/Bellabeat-Capstone/assets/125935435/4679fd33-50b3-4da0-b875-03083aee64f6)


**Checking to see how many users participated in each table data source:**

```SQL

# Selecting the distinct count of Ids for Daily_Activity
SELECT COUNT (DISTINCT Id) AS Total_Ids
FROM `bellabeat.Daily_Activity`;
# 33 distinct Ids are shown

# Selecting the distinct count of Ids for Heartrate_Seconds
SELECT COUNT (DISTINCT Id) AS Total_Ids
FROM `bellabeat.Heartrate_Seconds`;
# 7 distinct Ids are shown

# Selecting the distinct count of Ids for Hourly_Calories
SELECT COUNT(DISTINCT Id) AS Total_Ids
FROM `bellabeat.Hourly_Calories`;
# 33 distinct Ids are shown

# Selecting the distinct count of Ids for Hourly_Intenstity
SELECT COUNT(DISTINCT Id) AS Total_Ids
FROM `bellabeat.Hourly_Intensity`;
# 33 distinct Ids are shown

# Selecting the distinct count of Ids for Hourly_Steps
SELECT COUNT(DISTINCT Id) AS Total_Ids
FROM `bellabeat.Hourly_Steps`;
# 33 distinct Ids are shown

# Selecting the distinct count of Ids for Sleep_Day
SELECT COUNT(DISTINCT Id) AS Total_Ids
FROM `bellabeat.Sleep_Day`;
# 24 distinct Ids are shown

# Selecting the distinct count of Ids for Weight_Log
SELECT COUNT(DISTINCT Id) AS Total_Ids
FROM `bellabeat.Weight_Log`;
# 8 distinct Ids are shown

```

*Findings:* 3 of the 7 tables, Heartrate_Seconds, Weight_Log, and Sleep_Day, have missing participant numbers. 2 of the 3, Heartrate_Seconds and Weight_Log, are not showing enough data in order to continue so it's best to leave those out of this analysis. 

### User insights
Understanding how customers actively interact with their goods is a priority for FitBit and Bellabeat. In this analysis, we aim to explore the relationship between user counts and login frequency, providing insights into user utilization patterns. We can learn a lot about how users engage with the product by looking at the breakdown of user counts across various login frequencies.

```SQL
#Want to show a breakdown of the number of users for each login count
SELECT 
  Login_Count,
  COUNT(*) AS User_Count
FROM (
  SELECT 
    Id,
    COUNT(*) AS Login_Count
  FROM `bellabeat.Daily_Activity`
  GROUP BY Id
) AS Login_Counts
GROUP BY Login_Count 
ORDER BY Login_Count DESC;
#Highest is 31 times logged in by 21 users and lowest being 4 times logged in by 1 user

```
![Screenshot 2023-06-29 at 6 42 15 PM](https://github.com/vanessadailey/Bellabeat-Capstone/assets/125935435/324810e5-da7c-477b-9286-50ddc8da9ce3)

Next, I wanted to visualize **Breakdown of User Count by Login Count** using R:
![Screenshot 2023-06-29 at 6 42 53 PM](https://github.com/vanessadailey/Bellabeat-Capstone/assets/125935435/e2d5f625-eaba-4bd9-b1fb-a05c0a0c1516)


*Findings:* These results point to a significant amount of active usage. A few people, including one who only logged in four times, had lower login rates. These variances could be explained by personal preferences and routines. For the purpose of product optimization and improving user experiences, understanding user counts and login frequencies offers useful insights. Based on usage patterns, it aids in designing features and enhancing engagement.

Then I wanted to see the breakdown of **Low Usage, Medium Usage, and High Usage** and their percentages.

```SQL
#Organzing data into categories: High_Usage, Moderate_Usage, Low_Usage
#Then counting the Id in each category and calculcating the percentages
SELECT
  High_Usage_Count,
  Moderate_Usage_Count,
  Low_Usage_Count,
  ROUND(High_Usage_Count * 100.0 / Total_Count,2) AS High_Usage_Percentage,
  ROUND(Moderate_Usage_Count * 100.0 / Total_Count,2) AS Moderate_Usage_Percentage,
  ROUND(Low_Usage_Count * 100.0 / Total_Count,2) AS Low_Usage_Percentage
FROM (
  SELECT
    COUNT(CASE WHEN Usage_Category = 'High Usage' THEN Id END) AS High_Usage_Count,
    COUNT(CASE WHEN Usage_Category = 'Moderate Usage' THEN Id END) AS Moderate_Usage_Count,
    COUNT(CASE WHEN Usage_Category = 'Low Usage' THEN Id END) AS Low_Usage_Count,
    (SELECT COUNT(*) FROM `bellabeat.Daily_Activity`) AS Total_Count
  FROM (
    SELECT Id,
      CASE
        WHEN COUNT(Id) >= 25 THEN 'High Usage'
        WHEN COUNT(Id) BETWEEN 15 AND 24 THEN 'Moderate Usage'
        WHEN COUNT(Id) <= 14 THEN 'Low Usage'
        ELSE 'Invalid'
      END AS Usage_Category
    FROM `bellabeat.Daily_Activity`
    GROUP BY Id
  ) AS Usage_Data
) AS Total;

```

Most of the users were in the High Usage category which was based on logging in 25 or more days, Moderate Usage is next with logging in 15 to 24 days, and Low Usage only had one count for those who logged in 14 or less days. 

### Monitor activity level
Participants' activity levels can vary day-to-day and week-to-week based on their lifestyles. To determine the most active day of the week, I focused on step counts as a universal measure of movement. This approach allowed me to identify trends and patterns, highlighting the days when participants engaged in any form of physical activity.

```SQL
#Start looking into days of week when people track their activity most
SELECT
    Day_of_Week,
    SUM(Total_Steps) AS Total_Steps_Taken
FROM
    (SELECT
        Activity_Date,
        FORMAT_DATE('%A', Activity_Date) AS Day_of_Week,
        Total_Steps
    FROM
        `bellabeat.Daily_Activity`
    ) AS Activity_Day_Type
GROUP BY
    Day_of_Week;
```

![Screenshot 2023-06-29 at 6 44 55 PM](https://github.com/vanessadailey/Bellabeat-Capstone/assets/125935435/13deaed8-0568-460a-adf6-0d93ce1882f3)

Visualize **Day of the Week vs. Total Steps Taken**:
![Screenshot 2023-06-29 at 6 45 25 PM](https://github.com/vanessadailey/Bellabeat-Capstone/assets/125935435/7b70fc67-356a-4fc8-9c4f-2bdce3f40fc7)

Tuesday is when the most activity is seen with Wednesday, Thursday, and Saturday in that order as the next highest. Earlier in the week people get more active than towards the end of the week.

Then I wanted to see the calories burned for each day of the week and how many users logged in for each day of the week.

```SQL
#Break it down for each day of the week: total calories, steps taken and number of users logged in for each day of the week
SELECT
  FORMAT_DATE('%A', Activity_Date) AS Day_of_Week,
  SUM(Calories) AS Total_Calories,
  SUM(Total_Steps) AS Steps_Taken,
  COUNT(Id) AS Num_Users
FROM
  `bellabeat.Daily_Activity`
GROUP BY
  Day_of_Week
ORDER BY
  Num_Users DESC;
```
![Screenshot 2023-06-29 at 6 46 01 PM](https://github.com/vanessadailey/Bellabeat-Capstone/assets/125935435/3f8da7bb-2a66-4d89-898e-4e37cd20f942)
Not a significant difference in calories burned with higher amount steps taken to lower amount of steps taken.

The CDC recommends that people get around 10,000 steps per day. I wanted to see if any of the participants met these requirements and how many.

```SQL
#Parse the data to see how many of the participants meet the recommended quota
SELECT
  DISTINCT Id,
  ROUND(AVG(Total_Steps),2) AS Avg_Total_Steps,
  CASE 
    WHEN AVG(Total_Steps) >= 10000 THEN 'Meets CDC Recommendation'
   WHEN AVG(Total_Steps) < 10000 THEN 'Does Not Meet CDC Recommendation'
    ELSE 'Invalid'
  END CDC_Recommended_Steps
FROM `bellabeat.Daily_Activity`
GROUP BY Id;
#Shows a list of each participant and if they meet the goal or not

```

Now time to visualize **Participant Count vs. Meeting CDC Recommendation** in R:

![Screenshot 2023-06-29 at 6 46 48 PM](https://github.com/vanessadailey/Bellabeat-Capstone/assets/125935435/b9d32a3d-7308-4b2d-bed0-abd33e371178)
Most participants, at 26 count, do not meet the recommended daily step count while 7 participants do.

Next, I wanted to breakdown the activity levels to see the percentages from **Sedentary Minutes, Light Active Minutes, Fairly Active Minutes, and Very Active Minutes**.

![Screenshot 2023-06-29 at 6 47 30 PM](https://github.com/vanessadailey/Bellabeat-Capstone/assets/125935435/10298bd2-7405-439b-a3bd-9244b3252532)


Sedentary takes the cake in this pie chart following lightly active minutes, very active minutes and lastly, fairly active minutes. This indicates that a significant amount of time is spent in sedentary activities, such as sitting or lying down, which can have negative health implications.

### Checking sleeping patterns based on activity
I wanted to see if different activity levels led to more or less sleep time. Understanding how activity levels affect sleep duration is essential for this data analysis for a number of reasons. First of all, it offers information about the general health and wellbeing of users. Bellabeat can provide individualized advice and actions to enhance sleep quality by analyzing how various exercise levels affect sleep length. The patterns and connections between physical activity and sleep that are revealed by this analysis can also be used to guide the creation of new devices and application features and functions.


![Screenshot 2023-06-29 at 6 48 06 PM](https://github.com/vanessadailey/Bellabeat-Capstone/assets/125935435/26fc52ac-9adc-45cb-9bd6-635f5ecba400)

Visualizing **Sleep Time vs. Activity Levels**
<img width="837" alt="Screenshot 2023-06-29 at 12 23 41 PM" src="https://github.com/vanessadailey/Bellabeat-Capstone/assets/125935435/ba34bf5e-fcb9-4cbf-afc0-a2a89b61099a">
Only sedentary minutes had a drastic effect on sleep time going in a negative direction with a moderate negative linear relationship.

Then, I wanted to see the correlation between **Calories Burned and Minutes Asleep**. 
<img width="784" alt="Screenshot 2023-06-29 at 12 16 47 PM" src="https://github.com/vanessadailey/Bellabeat-Capstone/assets/125935435/b6900a06-d921-4c56-8d69-22669f051900">
Not a strong relationship showing that the amount of calories burned during physical activity does not necessarily have a significant impact on sleep duration or quality.

*Findings:* This finding suggests that factors other than calorie expenditure, like personal sleep habits, lifestyle circumstances, and general health, may influence sleep patterns more so than previously thought. It emphasizes how crucial it is to take into account a variety of variables and use a comprehensive strategy when examining sleep data and how it relates to physical activity.

## 6 → Act
In this final step, it's time to parse through all the information and research done on this FitBit user data and provide recommendations based on the analysis.

### Findings:
**User Insights**
- (Breakdown of User Count by Login Count): The data reveals interesting usage patterns among FitBit customers, with a significant number of people showing ongoing engagement through consistent login attempts. This suggests a positive response to the product and indicates a high level of involvement and curiosity.

**Activity Levels**
- **(Day of the Week vs. Total Steps Taken):** The data shows a pattern where individuals engage in more physical activity early in the week (Tuesday, Wednesday, Thursday) compared to later in the week. Understanding these trends can help identify factors influencing participation and develop strategies to promote consistent physical activity.
- **(Participant Count vs. Meeting CDC Recommendation):** The majority of participants (26) did not meet the recommended daily step count of 10,000, highlighting the need for promoting physical exercise to improve overall health and well-being.
- **(Breakdown of the Activity Levels):** The findings highlight the importance of addressing sedentary behavior, which can have detrimental effects on health. By understanding the prevalence of sedentary behaviors, Bellabeat can design interventions and tools to promote physical activity and reduce inactive time.

**Calories**
- **(Calories Burned vs. Day of Week):** The consistent calorie burn throughout the week, with highest on Tuesdays and lowest on Mondays, emphasizes the value of maintaining a regular exercise routine for overall health and fitness.

**Sleep**
- **(Calories Burned vs. Minutes Asleep):** There is a weak correlation between calories burned and sleep duration, suggesting that exercise and calorie burn may not directly impact sleep length or quality. This highlights the complexity of factors influencing sleep and the need to consider multiple aspects of sleep habits and patterns.
- **(Sleep Time vs. Activity Levels):** Only sedentary minutes were found to significantly affect sleep time, indicating that prolonged sedentary behavior may lead to shorter sleep duration. Other activity levels did not show a notable relationship with sleep time. This underscores the importance of reducing sedentary time and increasing activity levels throughout the day to promote better sleep health.

### Recommendations:
- **Improve User Experience:** Consistently enhance FitBit's functionality, user interface, and overall experience in considering usage trends and other information gleaned from consumer behavior. By enhancing the user experience and promoting client loyalty, this may also draw in new users.
- **Promote Physical Activity:** Establish focused campaigns and activities to get consumers to take the advised number of steps per day, or more. To encourage users to be more active and keep up a regular exercise schedule, this might include tailored challenges, prizes, and motivational material.
- **Address Sedentary Behavior:** Raise awareness about the negative health consequences of sedentary activities and give tools and reminders to assist users in reducing sedentary time. Implementing features that promote movement breaks, exercise reminders, and instructional materials on the value of keeping active all day can help with this.
- **Online Activity Challenges:** Develop fun and interesting online challenges using the Bellabeat platform to encourage people to move more. Step contests, virtual races, group challenges, and themed exercise events are a few examples of these challenges. Promote a sense of rivalry and accomplishment by providing incentives, badges, and leaderboard rankings.
- **Social Sharing Tools:** Incorporate social sharing tools into the Bellabeat app, allowing users to share their challenge progress, achievements, and workout information with friends and social media networks. Encourage users to share challenges with their friends, and foster a community where participants may support one another and share their fitness journeys.
- **Collaborate with Health Professionals:** Form alliances with healthcare practitioners, fitness experts, and wellness influencers to promote products like Bellabeat's Leaf as a viable tool for monitoring and improving health. Potential customers' confidence and trust can be increased as a result, and Bellabeat's brand's global reach can be increased.
- **Continuous Data Analysis:** Maintain an ongoing data analysis process to discover new trends, patterns, and customer preferences. As a result, Bellabeat will be able to modify its tactics, roll out new services, and keep ahead of market needs, ultimately boosting user engagement and drawing in a larger customer base.

In conclusion, Bellabeat can encourage people all over the world to lead healthier, more active lives while growing its customer base and expanding its global reach by applying these creative online challenges and cultivating a thriving community of active people.
