# GDAL_crop function #####################

#Adapted from https://github.com/MirzaCengic/gdalR/blob/master/R/GDAL_crop.R

#' Crop raster
#'
#' The function crops rasters (to the shapefile boundary) using GDAL.
#'
#' @param input_raster Raster to be cropped (file path or Raster object). Input raster should be stored on disk for GDAL access.
#' @param filename Output raster path.
#' @param shapefile_path Shapefile that is used to crop the raster. Disk path, \strong{not sp or sf object}.
#' @param return_raster Logical. The function stores the raster in the \code{filename} argument path as a side-effect.
#'
#' @return Raster object. Only if \code{return_raster = TRUE}. Otherwise, the function side-effect is to save the file locally.
#' @export
#'
#' @importFrom pkgmaker file_extension
#' @importFrom raster raster
#' @examples
#' library(gdalR)
#'

GDAL_crop <- function(input_raster, filename, shapefile_path, return_raster = TRUE)
{
  
  if (missing(filename))
  {
    filename <- tempfile(fileext = ".tif")
    warning("Argument filename is missing. Temporary raster file will be created.")
  }
  # Set vrt filename
  outfile_vrt <- gsub(pkgmaker::file_extension(filename), "vrt", filename)
  
  if (inherits(input_raster, "Raster"))
  {
    input_raster <- input_raster@file@name
  }
  
  
  gdalUtils::gdal_setInstallation()
  
  my_path <- normalizePath(getOption("gdalUtils_gdalPath")[[1]]$path)
  
  
  # Make system calls
  cut_to_VRT <- paste0(my_path, "gdalwarp.exe -ot Float32 -of GTiff -cutline", " ", shapefile_path, " ", "-crop_to_cutline", " ", input_raster, " ", outfile_vrt)
  VRT2TIF <- paste0(my_path, "gdal_translate.exe -co compress=LZW", " ", outfile_vrt, " ", filename)
  
  # Run sytem calls
  system(cut_to_VRT)
  system(VRT2TIF)
  # Remove vrt file
  unlink(outfile_vrt)
  
  if (return_raster)
  {
    library(raster)
    out <- raster::raster(filename)
    return(out)
  }
}