# -*- coding: utf-8 -*-
"""
Created on Tue Jul 28 08:41:28 2020

Group data daily and create concatenated dataframe where's number of events per day per polygon

example
index    date            sum   NAME
0        2012-01-20      5     Jeejee
1        2012-01-20      3     Juujuu   

'Jeejee' and 'Juujuu' representing point count inside different polygons

Notes:
    - script created using FIMRS VIIRS active fire data

@author: Ap
"""

import pandas as pd
import geopandas as gpd

# function to count sum and group them by day
def groupByDate(df, dateindex):
    # empty column for cumulative sum
    df['sum'] = 1
    
    # group by date
    df_group = df.groupby('ACQ_DATE')['sum'].sum()
    df_group.index = pd.DatetimeIndex(df_group.index) # set index as datetimeindex
    
    # reindex to date range and fill empty rows with 0
    df_group = df_group.reindex(dateindex) #, fill_value=0) #fill value adds zeros to empty dates, otherwise NaN
    
    # convert Series to DataFrame and count cumulative sum to new column
    df_out = pd.Series.to_frame(df_group)
    #df_out['cumsum'] = df_out['sum'].cumsum()
    
    return df_out;

# filepaths
fp_points = r'C:\Users\Ap\Documents\ProtectedAreas\FireAlert\Madagascar\fire_Jan2012_June2020_PAs.shp'
fp_polys = r'C:\Users\Ap\Documents\ProtectedAreas\Madagascar\WDPA\WDPA_June2020_Mada_final_PAs2.shp'
df_out = r'C:\Users\Ap\Documents\ProtectedAreas\FireAlert\Madagascar\Fires_per_PA_Jan2012_June2020.csv'


# read data
pts = gpd.read_file(fp_points)
polys = gpd.read_file(fp_polys)

# set daterange
daterange = pd.date_range('2012-01-20', '2020-06-30')

# subset for testing
#sel = pts.iloc[0:5000]

# filter low confidence out
sel = pts[pts['CONFIDENCE'] != 'l']

# keep only relevant columns
sel = sel[['ACQ_DATE', 'geometry']]

# new dataframe for results
result = pd.DataFrame()

# running number
i = 0

# loop through polygons 
while i < len(polys): # can use just '<' here, because indexing starts from 0, but len() returns the DataFrame length from 1
    # select one polygon
    poly = polys.iloc[[i]]
    # keep only relevant columns
    poly = poly[['NAME', 'geometry']]
    
    # get polygon name
    polyname = poly['NAME'].iloc[0]
    
    # clip data by polygon
    pts_clip = gpd.clip(sel, poly)
    
    # group by date and count sum
    grouped = groupByDate(pts_clip, daterange)
    
    # drop na rows
    grouped = grouped.dropna(axis=0, how='any')
    
    # add name column for grouped points
    grouped['NAME'] = polyname
    
    # reset datetime index and rename index column
    grouped = grouped.reset_index()
    grouped = grouped.rename(columns={'index':'date'})
    
    # add result to dataframe
    result = pd.concat([result,grouped], axis=0)
    
    i += 1
    print(str(i)+ '/' + str(len(polys)))
    

# write result as csv table
result.to_csv(df_out, sep=';', header=True)



























