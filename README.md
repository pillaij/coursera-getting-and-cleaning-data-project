# Getting and Cleaning Data - Course Project

Coursera course project for the Getting and Cleaning Data - Week 4 Assignment.

The R script, `run_analysis.R`, does the following:

1. Download the dataset from "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip" in the working directory
   Unzip the file.
2. Load activity and feature info
3. Loads both the training and test datasets, only selecting the columns 
   for mean and standard deviation
4. Loads the activity and subject data for each dataset and merges those
   columns with the original dataset.
5. Merges the two datasets into one
6. Converts the `activity` and `subject` columns to factors.
7. Creates a tidy dataset that consists of the average (mean) value of each
   variable for each subject and activity pair.

The end result is shown in the file "tidy_averages_data.csv".

