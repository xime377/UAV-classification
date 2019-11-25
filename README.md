UAV-classification
==================

Scripts for UAV RGB image classification. This workflow was designed to detect and quantify palm trees in the rainforest. They were developed within the MonANPeru project. In case of usage, **please do not forget to cite this repository.** 

Most of the process is run in R but for some tasks GRASS GIS is required. Before start running the scripts, please check if GRASS GIS is installed in your PC or download it from [here](https://grass.osgeo.org/download/software/ms-windows/).

Steps:
------

##### In case of the need to crop the UAV image use the following scripts:

0.1. Point_to_poly Script to create a polygon that will define the area of subset

0.2. Clipping.R Script to subset de image to an area of interest using GDAL



##### In case of having very high resolution mosaics and working with big crowns, 5cm resolution is enough: 

0.3. Aggregating.R Script to reduce the mosaic spatial resolution 



##### To start the process use the following scripts:

1. Segmentation.R Script to segment the image using GRASS GIS
2. Texture extraction.R Script to extract information from each segment of the image
3. Canopy_Height.R Script to obtain the canopy height by subtracting the DTM from the DSM
4. Layer_stacking.R Script to combine all the layers that will be used for the classification
7. Training_set.R Script to extract the information for training and validating the classification
8. Classification.R Script with the classification methods and accuracy assessment
11. Count_palms.R Script to 



##### Additional Scripts:

0. List_scripts.R Script to list all the scripts related to one task, one per mosaic, in order to run them in a batch process
0.4. Plot_mosaics.R Script to plot the mosaics and save them as images
0.5. Stats_plots.R Script to calculate the statistics of the RAINFOR plots (ground data)
5. Join_gps_forestplot.R Script to make a join between the GPS data and the foresplot info
6. Count_species.R Script that counts the number of individuals per palm tree species from the forestplots database per RAINFOR plot
9. Model_comparison.R Script to compare the results of the different classification techniques used
9. Acc_comparison.R Script to plot the results of the classification per plots
10. FeatureSelection.R Script to select the features that will be used into the object-based classification
12. Comparison_count.R Script to compare the results of the quantification with the ground data

** **
