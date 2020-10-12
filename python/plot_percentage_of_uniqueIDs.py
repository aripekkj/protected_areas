# -*- coding: utf-8 -*-
"""
Created on Mon Oct 12 12:50:49 2020

@author: aripekkj
"""


import pandas as pd
import geopandas as gpd
import matplotlib.pyplot as plt

# filepath
fp = r'E:/LocalData/aripekkj/ProtectedAreas/Madagascar/some/Madagascar_all_flickr.gpkg'
wdpa_fp = r'E:LocalData/aripekkj/ProtectedAreas/Madagascar/WDPA/WDPA_June2020_Mada_final_PAs2.shp'

# read files
df = gpd.read_file(fp)
wdpa = gpd.read_file(wdpa_fp)

# check col names
df.columns

# function input: dataframe, date column (string), begin and end date
def selectByDate(dframe, col, begin_date, end_date):
    sel = dframe[(dframe[col] >= begin_date) & (dframe[col] <= end_date)]
    return sel

# select
df_sel = selectByDate(df, 'date_taken', '2005-01-01', '2018-12-31')

# clip by wdpa
pts_wdpa = gpd.clip(df_sel, wdpa)

# unique user ids
df_users = len(df_sel.user_id.unique())
wdpa_users = len(pts_wdpa.user_id.unique())

# spatial join of points to pas
sj = gpd.sjoin(df_sel, wdpa, op='within')

# column for sum of posts
sj['sum'] = 1

# groupby PA name and user_id. Returns sum of posts per user
sj_grouped = sj.groupby(['NAME', 'user_id']).size()
# to df
df_grouped = sj_grouped.to_frame()
df_grouped = df_grouped.reset_index()

# groupby PA name, returns number of rows per pa
df_grouped2 = df_grouped.groupby(['NAME']).size()
df_grouped2 = df_grouped2.to_frame()
df_grouped2 = df_grouped2.reset_index()
# rename unnamed column
df_grouped2 = df_grouped2.rename(columns={0: 'sum_uniq_users'})

# calculate proportion of unique ids in Madagascar
df_grouped2['uniq_us_prop'] = df_grouped2['sum_uniq_users'] / df_users * 100

# arrange alphabetically
df_grouped2 = df_grouped2.sort_values(by='NAME', ascending=False)

# img fp
img_out = r'E:/LocalData/aripekkj/ProtectedAreas/Madagascar/some/visitor_percentage.png'

# text string to add
txt = 'Total unique users: ' + str(df_users) + '\nTotal Unique users in PAs: ' + str(wdpa_users)

# plot
fig = plt.figure()
ax = fig.add_subplot(111)

# tick labelsize
ax.tick_params(axis='y', labelsize=3)
ax.tick_params(axis='x', labelsize=5)
# data to plot
plt.barh(df_grouped2['NAME'], df_grouped2['uniq_us_prop'])
#('NAME', 'sum_uniq_users', kind='barh', fontsize=3, legend=False)
ax.set_ylabel('Protected Area', fontsize=8)
ax.set_xlabel('% of total unique user ids in Madagascar', fontsize=8)

# grid
ax.grid(True, which='major', axis='x', linestyle='--', linewidth=0.5)

# add text
ax.text(12, 10, txt, fontsize=4, bbox=dict(facecolor='black', alpha=0.3))

# title
ax.set_title('Percentage of unique users from 2005-2018 \n visiting Protected areas in Madagascar', fontsize=10)
fig.tight_layout(pad=5)
plt.savefig(img_out, dpi=600)
plt.show()





















