#First install packages to be used
install.packages("tidyverse")
install.packages("ggplot2")
install.packages("RColorBrewer")
install.packages("magrittr")
install.packages("scales")
install.packages("viridis")



library(tidyverse)
library(ggplot2)
library(RColorBrewer)
library(magrittr)
library(lubridate)
library(dplyr)
library(tidyr)
library(scales)
library(viridis)

#Load files

Sleep_Day <- read.csv("/Users/vanessa/Desktop/Daily_Sleep_Merged.csv")
Daily_Activity <- read.csv("/Users/vanessa/Desktop/Daily_Activity_Merged.csv")
Sleep_Day <- read.csv("/Users/vanessa/Desktop/Daily_Sleep_Merged.csv")
Hourly_Calories <- read.csv("/Users/vanessa/Desktop/Hourly_Calories_Merged.csv")
Hourly_Intensity <- read.csv("/Users/vanessa/Desktop/Hourly_Intensity_Merged.csv")
Hourly_Steps <- read.csv("/Users/vanessa/Desktop/Hourly_Steps_Merged.csv")

summary(Daily_Activity)
summary(Sleep_Day)
summary(Hourly_Calories)
summary(Hourly_Intensity)
summary(Hourly_Steps)

# Want to show a breakdown of the number of users for each login count
Login_Counts_Data <- Daily_Activity %>%
  group_by(Id) %>%
  summarize(Login_Count = n()) %>%
  group_by(Login_Count) %>%
  summarize(User_Count = n()) %>%
  arrange(desc(Login_Count))


print(Login_Counts_Data)

#Visualizing the login count and user count in a bar chart
ggplot(Login_Counts_Data, aes(x = Login_Count, y = User_Count, fill = User_Count)) +
  geom_bar(stat = "identity") +
  geom_text(aes(label = User_Count), vjust = -0.5, color = "black", size = 3) +  # Add numbers on top of the bars
  scale_fill_gradient(low = "#F3CFC6", high = "#9F2B68") +
  labs(x = "Login Count", y = "User Count", title = "Breakdown of User Count by Login Count")


# Calculate average total steps and categorize based on CDC recommendation
StepSummary <- Daily_Activity %>%
  group_by(Id) %>%
  summarize(
    Avg_Total_Steps = round(mean(Total_Steps), 2),
    CDC_Recommended_Steps = case_when(
      Avg_Total_Steps >= 10000 ~ "Meets CDC Recommendation",
      Avg_Total_Steps < 10000 ~ "Does Not Meet CDC Recommendation",
      TRUE ~ "Invalid"
    )
  ) %>%
  distinct()  # Remove duplicate Ids

# Calculate participant count and percentage
Summary <- StepSummary %>%
  group_by(CDC_Recommended_Steps) %>%
  summarize(
    Participant_Count = n_distinct(Id),
    Percentage = round((n_distinct(Id) / n_distinct(StepSummary$Id)) * 100, 2)
  )

# Print the resulting data frame
print(Summary)

# Define the color palette
color_low <-  "#F3CFC6"
color_high <- "#9F2B68"

# Create a bar chart to visualize if participants meet CDC Recommended Steps
ggplot(Summary, aes(x = CDC_Recommended_Steps, y = Participant_Count, fill = CDC_Recommended_Steps)) +
  geom_bar(stat = "identity") +
  geom_text(aes(label = Participant_Count), vjust = -0.5) +
  labs(x = "CDC Recommendation", y = "Participant Count", fill = "CDC Recommendation") +
  ggtitle("Distribution of Meeting CDC Daily Steps Recommendation") +
  theme_minimal() +
  scale_fill_manual(values = c(color_low, color_high))


#Upload updated CSV to show weekdays and weekend names
Daily_Activity_Weekdays_Weekends <- read_csv("/Users/vanessa/Desktop/Daily_Activity_Merged_Weekday.csv")


# Convert Activity_Day to a factor with ordered levels
Daily_Activity_Weekdays_Weekends$Activity_Day <- factor(Daily_Activity_Weekdays_Weekends$Activity_Day, levels = c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"), ordered = TRUE)

# Calculate the total steps by day of the week
Steps_By_Day <- Daily_Activity_Weekdays_Weekends %>%
  group_by(Activity_Day) %>%
  summarize(Total_Steps = sum(TotalSteps)) %>%
  arrange(desc(Total_Steps))  # Sort in descending order

# Print the resulting data frame
print(Steps_By_Day)


# Using a bar chart across the days of the week vs total steps for each day
ggplot(Steps_By_Day, aes(x = Activity_Day, y = Total_Steps, fill = Total_Steps)) +
  geom_col(color = "black") +
  scale_fill_gradient(low = "#F3CFC6", high = "#9F2B68") +
  labs(x = "Day of the Week", y = "Total Steps") +
  ggtitle("Total Steps by Day of the Week") +
  theme_minimal()

#Want to see the share of each type of activity in minutes
Activity_In_Minutes <- Daily_Activity %>%
  group_by(Id) %>%
  summarize(sedentary_mins = sum(Sedentary_Minutes),
            lightly_active_mins = sum(Lightly_Active_Minutes),
            fairly_active_mins = sum(Fairly_Active_Minutes),
            very_active_mins = sum(Very_Active_Minutes))

# Calculate the total minutes for each activity type
Total_Sedentary <- sum(Activity_In_Minutes$sedentary_mins)
Total_Lightly_Active <- sum(Activity_In_Minutes$lightly_active_mins)
Total_Fairly_Active <- sum(Activity_In_Minutes$fairly_active_mins)
Total_Very_Active <- sum(Activity_In_Minutes$very_active_mins)

# Calculate the percentages for each activity type
Percent_Sedentary <- (Total_Sedentary / (Total_Sedentary + Total_Lightly_Active + Total_Fairly_Active + Total_Very_Active)) * 100
Percent_Lightly_Active <- (Total_Lightly_Active / (Total_Sedentary + Total_Lightly_Active + Total_Fairly_Active + Total_Very_Active)) * 100
Percent_Fairly_Active <- (Total_Fairly_Active / (Total_Sedentary + Total_Lightly_Active + Total_Fairly_Active + Total_Very_Active)) * 100
Percent_Very_Active <- (Total_Very_Active / (Total_Sedentary + Total_Lightly_Active + Total_Fairly_Active + Total_Very_Active)) * 100

# Create the labels for the pie chart
labels <- c("Sedentary", "Lightly Active", "Fairly Active", "Very Active")

# Create the percentages vector
percentages <- c(Percent_Sedentary, Percent_Lightly_Active, Percent_Fairly_Active, Percent_Very_Active)

# Define the colors range
color_low <- "#9F2B68"
color_high <-  "#F3CFC6"

# Create the pie chart
pie(percentages, labels = paste(labels, sprintf("(%1.1f%%)", percentages)), col = colorRampPalette(c(color_low, color_high))(length(labels)))

# Add a legend
legend("topright", legend = paste(labels, sprintf("(%1.1f%%)", percentages)), cex = 0.8, fill = colorRampPalette(c(color_low, color_high))(length(labels)))



#Seeing how many days the participants got 7-9 hrs of sleep

If_7_to_9_Hours_Asleep <- Daily_Activity %>%
  left_join(Sleep_Day, by = c("Id", "Activity_Date" = "Sleep_Day")) %>%
  mutate(Activity_Date = as.Date(Activity_Date),
         Day_of_Week = ifelse(!is.na(Total_Minutes_Asleep) & Total_Minutes_Asleep >= 420 & Total_Minutes_Asleep <= 540,
                              weekdays(Activity_Date),
                              NA)) %>%
  filter(!is.na(Day_of_Week)) %>%
  group_by(Day_of_Week) %>%
  summarize(Num_Days = n()) %>%
  arrange(desc(Num_Days))

print(If_7_to_9_Hours_Asleep)

#Want to see correlation to activity and hours of sleep
Hours_Alseep_vs_Activity <- Daily_Activity %>%
  inner_join(Sleep_Day, by = c("Id" = "Id", "Activity_Date" = "Sleep_Day")) %>%
  mutate(
    Total_Hours_Asleep = round(sum(Total_Minutes_Asleep) / 60, 2),
    Total_Very_Active_Hours = round(sum(Very_Active_Minutes) / 60, 2),
    Total_Fairly_Active_Hours = round(sum(Fairly_Active_Minutes) / 60, 2),
    Total_Lightly_Active_Hours = round(sum(Lightly_Active_Minutes) / 60, 2),
    Total_Sedentary_Hours = round(sum(Sedentary_Minutes) / 60, 2)
  ) %>%
  group_by(Id) %>%
  summarize(
    Total_Hours_Asleep = sum(Total_Hours_Asleep),
    Total_Very_Active_Hours = sum(Total_Very_Active_Hours),
    Total_Fairly_Active_Hours = sum(Total_Fairly_Active_Hours),
    Total_Lightly_Active_Hours = sum(Total_Lightly_Active_Hours),
    Total_Sedentary_Hours = sum(Total_Sedentary_Hours)
  ) %>%
  arrange(desc(Total_Hours_Asleep), Id)

print(Hours_Alseep_vs_Activity)

#Now in minutes not hours
Mins_Asleep_vs_Activity  <- Daily_Activity %>%
  inner_join(Sleep_Day, by = c("Id" = "Id", "Activity_Date" = "Sleep_Day")) %>%
  mutate(
    Total_Minutes_Asleep = round(sum(Total_Minutes_Asleep), 2),
    Total_Very_Active_Minutes = round(sum(Very_Active_Minutes), 2),
    Total_Fairly_Active_Minutes = round(sum(Fairly_Active_Minutes), 2),
    Total_Lightly_Active_Minutes = round(sum(Lightly_Active_Minutes), 2),
    Total_Sedentary_Minutes = round(sum(Sedentary_Minutes), 2)
  ) %>%
  group_by(Id) %>%
  summarize(
    Total_Minutes_Asleep = sum(Total_Minutes_Asleep),
    Total_Very_Active_Minutes = sum(Total_Very_Active_Minutes),
    Total_Fairly_Active_Minutes = sum(Total_Fairly_Active_Minutes),
    Total_Lightly_Active_Minutes = sum(Total_Lightly_Active_Minutes),
    Total_Sedentary_Minutes = sum(Total_Sedentary_Minutes)
  ) %>%
  arrange(desc(Total_Minutes_Asleep), Id)

print(Mins_Asleep_vs_Activity)

# Calculate the sum of Sedentary_Minutes and Total_Minutes_Asleep
Sum_Sedentary <- aggregate(Sedentary_Minutes ~ Id, Daily_Activity, sum)
Sum_Lightly_Active <- aggregate(Lightly_Active_Minutes ~ Id, Daily_Activity, sum)
Sum_Fairly_Active <- aggregate(Fairly_Active_Minutes ~ Id, Daily_Activity, sum)
Sum_Very_Active <- aggregate(Very_Active_Minutes ~ Id, Daily_Activity, sum)
Sum_Asleep <- aggregate(Total_Minutes_Asleep ~ Id, Sleep_Day, sum)


# Perform left join on "Id" and "Activity_Date" columns
Merged_Data <- merge(Daily_Activity, Sleep_Day, by.x = c("Id", "Activity_Date"), by.y = c("Id", "Sleep_Day"), all.x = TRUE)

# Save the merged data to a new CSV file
write.csv(Merged_Data, "Merged_Data.csv", row.names = FALSE)

# Scatter plot for Sedentary_Minutes
ggplot(Merged_Data, aes(x = Sedentary_Minutes, y = Total_Minutes_Asleep)) +
  geom_point(shape = 1, color = "#9F2B68", size = 4) +
  geom_smooth(method = "lm", se = FALSE, color = "black", size = 0.5) +
  labs(x = "Total Sedentary Minutes", y = "Total Minutes Asleep") +
  ggtitle("Total Minutes Asleep vs Total Sedentary Minutes") +
  theme_minimal()

# Scatter plot for Lightly_Active_Minutes
ggplot(Merged_Data, aes(x = Lightly_Active_Minutes, y = Total_Minutes_Asleep)) +
  geom_point(shape = 1, color = "#9F2B68", size = 4) +
  geom_smooth(method = "lm", se = FALSE, color = "black", size = 0.5) +
  labs(x = "Total Lightly Active Minutes", y = "Total Minutes Asleep") +
  ggtitle("Total Minutes Asleep vs Total Lightly Active Minutes") +
  theme_minimal()

# Scatter plot for Fairly_Active_Minutes
ggplot(Merged_Data, aes(x = Fairly_Active_Minutes, y = Total_Minutes_Asleep)) +
  geom_point(shape = 1, color = "#9F2B68", size = 4) +
  geom_smooth(method = "lm", se = FALSE, color = "black", size = 0.5) +
  labs(x = "Total Fairly Active Minutes", y = "Total Minutes Asleep") +
  ggtitle("Total Minutes Asleep vs Total Fairly Active Minutes") +
  theme_minimal()

# Scatter plot for Very_Active_Minutes
ggplot(Merged_Data, aes(x = Very_Active_Minutes, y = Total_Minutes_Asleep)) +
  geom_point(shape = 1, color = "#9F2B68", size = 4) +
  geom_smooth(method = "lm", se = FALSE, color = "black", size = 0.5) +
  labs(x = "Total Very Active Minutes", y = "Total Minutes Asleep") +
  ggtitle("Total Minutes Asleep vs Total Very Active Minutes") +
  theme_minimal()



# Calories vs. Minutes Asleep
Mins_Asleep_vs_Calories <- Daily_Activity %>%
  inner_join(Sleep_Day, by = c("Id" = "Id", "Activity_Date" = "Sleep_Day")) %>%
  group_by(Id) %>%
  summarize(
    Total_Minutes_Asleep = sum(Total_Minutes_Asleep),
    Total_Calories = sum(Calories)
  ) %>%
  arrange(desc(Total_Minutes_Asleep), Id)

print(Mins_Asleep_vs_Calories)

# Calculate the sum of Calories and Total_Minutes_Asleep
Sum_Calories <- aggregate(Calories ~ Id, Daily_Activity, sum)
Sum_Asleep <- aggregate(Total_Minutes_Asleep ~ Id, Sleep_Day, sum)


# Calories vs. Minutes Asleep
Merged_Data_2 <- merge(Daily_Activity, Sleep_Day, by.x = c("Id", "Activity_Date"), by.y = c("Id", "Sleep_Day"), all.x = TRUE)

# Save the merged data to a new CSV file
write.csv(Merged_Data_2, "Merged_Data_2.csv", row.names = FALSE)

# Scatter plot for Calories vs Total Minutes Asleep
ggplot(Merged_Data_2, aes(x = Calories, y = Total_Minutes_Asleep)) +
  geom_point(shape = 1, color = "#9F2B68", size = 4) +
  geom_smooth(method = "lm", se = FALSE, color = "black", linewidth = 0.5) +
  labs(x = "Total Calories", y = "Total Minutes Asleep") +
  ggtitle("Total Minutes Asleep vs Total Calories") +
  theme_minimal()



