#!/usr/bin/env python
# coding: utf-8

# In[1]:


##import libraries

import pandas as pd
import numpy as np
import statistics 

# `plt` is an alias for the `matplotlib.pyplot` module
import matplotlib.pyplot as plt


# In[2]:


##Import Datasets for Analysis

filename = 'C:\\Users\\Ryan\\Documents\\Grad School\\MIS581-CapstoneMSDA\\MPG_Vehicle_Type_Simple.csv'

df = pd.read_csv(filename)

filenameManu = 'C:\\Users\\Ryan\\Documents\\Grad School\\MIS581-CapstoneMSDA\\MPG_Manufacturer.csv'

dfManu = pd.read_csv(filenameManu)


# In[75]:


##Show first 5 rows of dataset

df.head()


# In[3]:


##Subset datset for different regulatory types

all_df = df[df['Regulatory Class'] == 'All']
car_df = df[df['Vehicle Type'] == 'All Car']
truck_df = df[df['Vehicle Type'] == 'All Truck']


# In[4]:


##Plot real-world MPG for different regulatory types

plt.figure(figsize=(30,10))
plt.plot(all_df['Model Year'], all_df['Real-World MPG'], label = "All")
plt.plot(car_df['Model Year'], car_df['Real-World MPG'], label = "All Car")
plt.plot(truck_df['Model Year'], truck_df['Real-World MPG'], label = "All Truck")

plt.legend(loc="upper left")
plt.title("Real-World MPG by Vehicle Type")


# In[5]:


##Plot production shares over time of cars and trucks

plt.figure(figsize=(30,10))

plt.plot(car_df['Model Year'], car_df['Production Share'], label = "All Car")
plt.plot(truck_df['Model Year'], truck_df['Production Share'], label = "All Truck")
plt.title("Production Shares of Vehicle Types")
plt.legend(loc="upper left")


# In[6]:


##Summary Statistics of dataset grouped by vehicle type

df.groupby(["Vehicle Type"]).describe()


# In[7]:


##Histogram of real-world miles per gallon for all regulatory types

plt.hist(all_df["Real-World MPG"])
plt.title("Real-World Miles Per Gallon Histogram")


# In[8]:


##Real-world MPG for cars

plt.hist(car_df["Real-World MPG"])
plt.title("Real-World Miles Per Gallon Histogram (Car)")


# In[9]:


##Real-World MPG histogram for trucks

plt.hist(truck_df["Real-World MPG"])
plt.title("Real-World Miles Per Gallon Histogram (Truck)")


# In[10]:


##first 5 rows of manufacturer dataset (entire dataset)

dfManu.head()


# In[11]:


##Subset manufacturer dataset

dfManuAll = dfManu[dfManu['Vehicle Type'] == 'All']
dfManuAll


# In[12]:


##Filter dataset by Ford as the Manufacturer for all vehicle types

dfFord = dfManu[dfManu['Manufacturer'] == 'Ford']
dfAllFord = dfFord[dfFord['Vehicle Type'] == 'All']


# In[13]:


##Show Ford's Real World MPG over time

plt.figure(figsize=(30,10))

plt.plot(dfAllFord['Model Year'], dfAllFord['Real0World MPG'], label = "Ford")

plt.title("Real-World MPG for Ford Motor Company")
plt.legend(loc="upper left")


# In[14]:


##Plot ford's production of Electric and Hybrid vehicles over time

plt.figure(figsize=(40,10))

plt.plot(dfAllFord['Model Year'], dfAllFord['Powertrain 0 Electric Vehicle (EV)'], label = "Electric")
plt.plot(dfAllFord['Model Year'], dfAllFord['Powertrain 0 Plug0in Hybrid Electric Vehicle (PHEV)'], label = "Plug In Hybrid")
plt.plot(dfAllFord['Model Year'], dfAllFord['Powertrain 0 Gasoline Hybrid'], label = "Gasoline Hybrid")
plt.title("Ford Electric/Hybrid Vehicles")
plt.legend(loc="upper left")


# In[ ]:




