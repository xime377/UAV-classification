UAV-classification
==================

Scripts for UAV classification. The next workflow is designed to detect and quantify palm trees in the rainforest. They were developed within the MonANPeru project. In case of usage, please do not forget to cite this repository. 

Most of the process is run in R but for some tasks GRASS GIS is required. Before start running the scripts, please check if GRASS GIS is installed in your PC or download it from here (https://grass.osgeo.org/download/software/ms-windows/).

Steps:

In case of the need to crop the UAV image use the following scripts:

0.1. Point_to_poly Script to create a polygon that will define the area of subset

0.2. Clipping.R Script to subset de image to an area of interest using GDAL

To start the process use the following scripts:
1. Segmentation.R Script to segment the image using GRASS GIS
2. Texture extraction.R Script to extract information from each segment of the image
3. Canopy_Height.R Script to obtain the canopy height by subtracting the DTM from the DSM
4. Layer_stacking.R Script to combine all the layers that will be used for the classification
5. Training_set.R Script to extract the information for training and validating the classification
6. Classification.R Script with the classification methods and accuracy assessment


* The scripts are still under development*
