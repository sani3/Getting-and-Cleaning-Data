# Getting-and-Cleaning-Data
Project for Getting and cleaning data on Coursera

This README document explains how the raw downloaded data was cleaned to obtain a tidy data set saved to the text file Tidy_Samsung_Data Set.txt

The data set was downloaded to the working directory from the url https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip.

The tables requred to reconstruct the data was read into R

The test sets and train sets were merged for X, Y and the Subject fields

from the features data, only features which included "mean()" or "std()" were selected and used to subset corresponding fields in the merged X data set. The subseted features were used to provide the column names for the subsetted data in the merged Xdata set.

colunm names were provided for the data in the Y, subject as well as the activity_labels data set

a new field was create for the Y dataset that provides the appropriate factor level for the activities

the subject, activity, and subsetted X data sets were merged to form one giant table

the data was reshaped and agregated over subjects with the mean function to obtain the required clean data





