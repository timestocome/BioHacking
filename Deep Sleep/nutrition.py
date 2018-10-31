#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Oct 31 12:38:27 2018

# http://github.com/timestocome
# Linda MacPhee-Cobb


# Look for correlations between daily nutrition, dinner nutrition
# and active calories and deep sleep

# I dropped the 'transfat' column because it was all zeros along with Notes


# Not what I was hoping for ---
# Disrupters of deep sleep: Vitamin A, C, Protein, working out
# Aids to deep sleep: Fat, fat and more fat. Also Cholesterol


# This is a small dataset and correlation does not prove causality 

"""

import pandas as pd



# pull in data downloaded from MyFitnessPal.com
# and manually added (Deep Sleep, Active Calories) from GarminConnect.com
data = pd.read_csv('/home/linda/Desktop/2018_nutrition.csv', parse_dates=True, index_col=0)
print(data.columns.values)

data['Deep Sleep'] = data['Deep Sleep'].convert_objects(convert_numeric=True)



# daily food correlation with sleep
daily = data.groupby('Date', as_index=True).sum()
print('Daily   -----------------------------------------------')

corr = daily.corr()['Deep Sleep']
corr = corr.sort_values()

print( corr )




# dinner correlation with deep sleep?
print('Dinner -------------------------------------------')
dinner = data.where(data['Meal'] == 'Dinner')
dinner.dropna(inplace=True)

corr = dinner.corr()['Deep Sleep']
corr = corr.sort_values()

print( corr )

print('---------------------------------------------------------')


