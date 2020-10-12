# -*- coding: utf-8 -*-
"""
Created on Tue Sep 15 15:31:41 2020

Join csv

@author: aripekkj
"""


import pandas as pd
import geopandas as gpd


# filepath
fp = r'E:\LocalData\aripekkj\ProtectedAreas\Madagascar\some\wdpa_mada_flickr_stats_2005-2018_userdays_only.csv'
fp2 = r'E:\LocalData\aripekkj\ProtectedAreas\Madagascar\WDPA\WDPA_June2020_Mada_final_PAs2.shp'
outfp = r'E:\LocalData\aripekkj\ProtectedAreas\Madagascar\WDPA\WDPA_final_PAs_w_flickr.shp'

# read file
csv = pd.read_csv(fp, sep=',')
pa = gpd.read_file(fp2)

# merge
merged = pd.merge(pa, csv, how='outer', on='WDPAID')

# save file
merged.to_file(outfp, driver='ESRI Shapefile')







