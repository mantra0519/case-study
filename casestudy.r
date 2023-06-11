---
title: "BELLABEAT CASE STUDY"
author: "Mantra"
date: "2023-06-08"
output: html_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```



# **About the company**

***Bellabeat***, is a high-tech manufacturer of health-focused products for women. Bellabeat is a successful small company, and they have the potential to become a larger player in the global smart device market. Urška Sršen and Sando Mur founded Bellabeat, a high-tech company that manufactures health-focused smart
products. 

Collecting data on activity, sleep, stress, and reproductive health has allowed Bellabeat to empower women with knowledge about their own health and habits. Since it was founded in 2013, Bellabeat has grown rapidly and quickly positioned itself as a tech-driven wellness company for women.

![bellabeat](images.jpeg)

# **Scenario of the study**
In this study, I will focus on one of Bellabeat’s products and analyze smart device data to gain insight into how consumers are using their smart devices.
The insights will then help guide marketing strategy for the company.

# **Questions for the analysis**

1. What are some trends in smart device usage? 
2. How could these trends apply to Bellabeat customers? 
3. How could these trends help influence Bellabeat marketing strategy

So first, the company need to better target their marketing efforts into their customer’s needs based on their usage of their fitness smart devices. And then, make high-level recommendations for how these trends can inform Bellabeat marketing strategy.

# Business task

Identify potential opportunities for growth and recommendations for the Bellabeat marketing strategy improvement based on trends in smart device usage.

# Installing packages
```{r message=FALSE, warning=FALSE, paged.print=FALSE}
install.packages("tidyverse")
install.packages("lubridate")
install.packages("dplyr")
install.packages("ggplot2")
install.packages("tidyr")
install.packages("here")
install.packages("skimr")
install.packages("janitor")
```

# Loading packages
```{r message=FALSE, warning=FALSE}

library(tidyverse)
library(lubridate)
library(dplyr)
library(ggplot2)
library(tidyr)
library(here)
library(skimr)
library(janitor)


```

# Importing datasets
Now, I’m going to Import all dataset. Then VIEW, CLEAN, FORMAT, and ORGANIZE the data. After reviewing all the dataset, I decided to make some assumptions and work only with these data for my analysis:

1-DailyActivity_merged.csv
```{r}
 Activity<-read.csv("dailyActivity.csv")
 head(Activity)
```
2-hourlycalories_merged.csv
```{r}
Calories<-read.csv("hourlyCalories_merged.csv")
head(Calories)
```
3-dailyintensities_merged.csv
```{r}
Intensities<-read.csv("dailyIntensities_merged.csv")
head(Intensities)

```
4-sleepday_merged.csv
```{r}
Sleep<-read.csv("sleepDay_merged.csv")
head(Sleep)
```
5-weightloginfo_merged.csv
```{r}
Weight<-read.csv("weightLogInfo_merged.csv")
head(Weight)
```
# **Cleaning the dataset (Process Phase)**

# Basic cleaning
Now, I’m going to Process, Clean and Organize the dataset for analysis.I used functions like glimpse(),skim_without_charts to quickly review the data. I also clean the names of the data using clean_names().

And here some cleaning steps I did with the data :

• For Dataset (Activity, Calories and Intensities): For the data cleaning steps, I did NOT FOUND in this data (Spelling errors, Misfield values, Missing values, Extra and blank space, no duplicated found). For formatting, I used clear formatting. For Data types, some data were converted to numeric and Dates
columns will be converted to date type.

```{r message=FALSE, warning=FALSE,include=FALSE}
clean_names(Intensities)
head(Intensities)
clean_names(Sleep)
head(Sleep)
clean_names(Activity)
head(Activity)


```


• For Sleep data : 3 duplicates were found and removed.
```{r  include=FALSE}
Sleep<-unique(Sleep)
head(Sleep)

```
• For Weight data : too many missing values were found in one column. And I decided to remove that column.
```{r include=FALSE}
Weight$Fat<-NULL
head(Weight)

```
# Fixing formatting
```{r}
#Activity
Activity$ActivityDate=as.POSIXct(Activity$ActivityDate, format="%m/%d/%Y", tz=Sys.timezone())
Activity$date <- format(Activity$ActivityDate, format = "%m/%d/%y")
Activity$ActivityDate=as.Date(Activity$ActivityDate, format="%m/%d/%y", tz=Sys.timezone())
Activity$date=as.Date(Activity$date, format="%m/%d/%y")
```




```{r}
# Intensities
Intensities$ActivityDay=as.Date(Intensities$ActivityDay, format="%m/%d/%Y", tz=Sys.timezone())
```

```{r}
# Calories
Calories$ActivityHour=as.POSIXct(Calories$ActivityHour, format="%m/%d/%Y %I:%M:%S %p", tz=Sys.timezone())
Calories$time <- format(Calories$ActivityHour, format = "%H:%M:%S")
Calories$date <- format(Calories$ActivityHour, format = "%m/%d/%y")
```
```{r}
# Sleep
Sleep$SleepDay=as.POSIXct(Sleep$SleepDay, format="%m/%d/%Y %I:%M:%S %p", tz=Sys.timezone())
Sleep$date <- format(Sleep$SleepDay, format = "%m/%d/%y")
Sleep$date=as.Date(Sleep$date, format="%m/%d/%y")

```

Now that everything is ready, I can start exploring and analyzing the data sets.

# **Summarizing the dataset (Analyze Phase)**
Let’s look at the total number of participants in each data sets:

```{r message=FALSE, warning=FALSE}
n_distinct(Activity$Id)
n_distinct(Calories$Id)
n_distinct(Intensities$Id)
n_distinct(Sleep$Id)
n_distinct(Weight$Id)
```

So, there are 33 participants in the activity, calories and intensities data sets. 24 participants in the Sleep data.  And only 8 in the weight data set. 8  participants are not significant to make any recommendations and conclusions based on these dataset.

So I will focus on these datasets for my analysis: Activity, Calories, Intensities and Sleep.
Here are some quick summary statistics about each data frame.

So for the activity dataframe.

```{r}
# Activity
Activity %>%
select(TotalSteps,
TotalDistance,
SedentaryMinutes, Calories) %>%
summary()
```

Exploring the number of Intense active participants :

```{r}
# Explore number of active minutes per category
Intensities %>%
select(VeryActiveMinutes, FairlyActiveMinutes, LightlyActiveMinutes, SedentaryMinutes) %>%
summary()

```
For the Calories dataframe:

```{r}
# Calories
Calories %>%
select(Calories) %>%
summary()

```
For the Sleep dataframe:

```{r}
# Sleep
Sleep %>%
select(TotalSleepRecords, TotalMinutesAsleep, TotalTimeInBed) %>%
summary()
```
For the Weight dataframe:

```{r}
# Weight
Weight %>%
select(WeightKg, BMI) %>%
summary()

```

# Key findings from this analysis :
• The average sedentary time is too high (more than 16 hours). And definitely needs to be reduced with a good marketing strategy.

• The majority of the participants are lightly active. With a high sedentary time.

• Participants sleep 1 time for an average of 7 hours.

• Average total steps per day (which is 7638) is a little bit less than recommended by the CDC. According to the CDC research, taking 8,000 steps per day was associated with a 51% lower risk for all-causemortality (or death from all causes). And taking 12,000 steps per day was associated with a 65% lower risk compared with taking 4,000 steps.

# Merging some data :

Before beginning to visualize the data, I’m going to merge two data sets : Activity and Sleep data on columns Id and date. 

Take a look :

```{r}
merged_data<- merge(Sleep,Activity, by=c('Id', 'date'))
head(merged_data)

```

# **Data visualization (Share and Act Phases)**

Now let’s visualize some key explorations.

Relationship between Steps and Sedentary time

What’s the relationship between steps taken in a day and sedentary minutes?
```{r warning=FALSE}
ggplot(data=Activity, aes(x=TotalSteps, y=SedentaryMinutes)) + geom_point() + geom_smooth() + labs(title = "Total steps vs. sedentary minutes")
```


I can see here a negative correlation between Steps and Sedentary time.
The more Sedentary time you have, the less Steps you’re taking during the day. This data shows that the company need to market more the customer segments with high Sedentary time. 
And to do that, the company needs to find ways to get customers get started in walking more and also measure their daily steps.

```{r warning=FALSE}
ggplot(data=Activity, aes(x=TotalSteps, y=Calories)) + 
  geom_point() + geom_smooth() + labs(title="Total Steps vs. Calories")
```


I see positive correlation here between Total Steps and Calories, which is obvious - the more active we are, the more calories we burn.


```{r warning=FALSE}
ggplot(data=Sleep, aes(x=TotalMinutesAsleep, y=TotalTimeInBed)) + 
  geom_point()+ geom_smooth()+ labs(title="Total Minutes Asleep vs. Total Time in Bed")
```

The relationship between Total Minutes Asleep and Total Time in Bed looks linear. So if the **Bellabeat users want to improve their sleep, we should consider using notification to go to sleep.**

Let's look at intensities data over time (hourly).

```{r warning=FALSE}
Intensities$ActiveIntensity <- (Intensities$VeryActiveMinutes)/60
Combined_data <- merge(Weight, Intensities, by="Id", all=TRUE)
Combined_data$time <- format(Combined_data$Date, format = "%H:%M:%S")
ggplot(data=Combined_data, aes(x=time, y=ActiveIntensity)) + geom_histogram(stat = "identity", fill='orange')+ theme(axis.text.x = element_text(angle = 90)) +
labs(title="Total very Active Intensity vs. Time ")

```


By analysing some Intensity data over time. The company will have a good idea on how customers are using their product during the day.
Most users are actif before and after work, I suppose. The company can use this time in the Bellabeat app to remind and motivate users to go for a run or for a walk.

Let's look at the relationship between Total Minutes Asleep and Sedentary Minutes.

```{r warning=FALSE}
ggplot(data=merged_data, aes(x=TotalMinutesAsleep, y=SedentaryMinutes)) + 
geom_point(color='darkgreen') + geom_smooth() +
  labs(title="Minutes Asleep vs. Sedentary Minutes")
```


* Here we can clearly see the negative relationship between Sedentary Minutes and Sleep time.

* As an idea: **if Bellabeat users want to improve their sleep, Bellabeat app can recommend reducing sedentary time.**

* Keep in mind that we need to support this insights with more data, because correlation between some data doesn’t mean causation.

# Conclusions & Recommandations for the Business

So, collecting data on activity, sleep, stress, etc. will allow the company Bellabeat to empower the customers with knowledge about their own health and daily habits. The company Bellabeat is growing rapidly and quickly positioned itself as a tech-driven wellness company for their customers.

By analyzing the FitBit Fitness Tracker Data set, I found some insights that would help influence Bellabeat marketing strategy.

![bellabeat](https://i.postimg.cc/kG18Nn66/front.png)

# Target Audience:

People working full-time jobs and spending a lot of time at the computer and in the office and need fitness and daily activities to be in shape.
The users are doing some light activity to stay healthy (according to the activity type analysis). And they need to improve their everyday activity to have more health benefits. And they might need some knowledge about developing healthy habits and motivation to keep them going.

# Message to the Company

The Bellabeat app need to be a unique fitness activity app. By becoming a companion guide (like a friend) to its users and customers and help them balance their personal and professional life with healthy habits.

• The average sedentary time is too high for the users of the app (more than 16 hours). And definitely needs to be reduced with a good marketing strategy. So, the data shows that the company need to market more to the customer segment with a high Sedentary time. And to do that, the company needs to find ways to get customers started in walking more by measuring their daily steps (+ notifications).

• Participants sleep 1 time for an average of 7 hours. To help users improve their sleep, Bellabeat should consider using app notifications to go to bed. And also, the Bellabeat app can recommend reducing sedentary time for its customers.

• The average total steps per day (which is 7638) is a little bit less than recommended by the CDC. According to the CDC research, taking 8,000 steps per day was associated with a 51% lower risk for all-cause mortality (or death from all causes). And taking 12,000 steps per day was associated with a 65% lower risk compared with taking 4,000 steps. So, Bellabeat can encourage people to take at least 8,000 steps per day by explaining the healthy benefits of doing that.

• By analysing the Intensity data over time. The company will have a good idea on how their customers are using their app during the day. Most users are actif before and after work. The company can use this time in the Bellabeat app to remind and motivate users to go for a run or for a walk.

• For customers who want to lose weight, it can be a good idea to control daily calorie consumption. And Bellabeat can suggest some ideas for low-calorie healthy food (for lunch and dinner).

Thank you very much for your interest in my Bellabeat Case Study!


