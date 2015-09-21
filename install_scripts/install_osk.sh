#! /bin/bash

# install dependencies of ASF

#----------------------------------
# 1 Adding extra repositories
#----------------------------------
## I GIS packages from ubuntugis (unstable)
add-apt-repository -y ppa:ubuntugis/ubuntugis-unstable

## II InSAR Packages Antonio Valentinos eotools 
add-apt-repository -y ppa:a.valentino/eotools

## III Java Official Packages
add-apt-repository -y ppa:webupd8team/java

#QGIS for 14.04
# add lines to sources
echo "deb http://qgis.org/ubuntugis trusty main" >> /etc/apt/sources.list
echo "deb-src http://qgis.org/ubuntugis trusty main" >> /etc/apt/sources.list
# add key
apt-key adv --keyserver keyserver.ubuntu.com --recv-key 3FF5FFCAD71472C4


#------------------------------------------------------------------
# 2 run update to load new packages and upgrade all installed ones
#------------------------------------------------------------------
apt-get update -y
apt-get upgrade -y 


#------------------------------------------------------------------
# 3 install packages
#------------------------------------------------------------------
# Gis Packages
apt-get install --yes qgis libqgis-dev gdal-bin libgdal-dev python-gdal saga libsaga-dev python-saga otb-bin libotb-dev libotb-ice libotb-ice-dev monteverdi2 python-otb geotiff-bin libgeotiff-dev gmt libgmt-dev dans-gdal-scripts	

## Spatial-Database Spatialite
apt-get install --yes spatialite-bin spatialite-gui #pgadmin3 postgresql postgis 

# Dependencies for ASF Mapready
apt-get install --yes libcunit1-dev libfftw3-dev libshp-dev libgeotiff-dev libtiff4-dev libtiff5-dev libproj-dev gdal-bin flex bison libgsl0-dev gsl-bin git libglade2-dev libgtk2.0-dev libgdal-dev pkg-config

## Java official
apt-get install --yes oracle-java8-installer oracle-java8-set-default

## Python libraries
apt-get install --yes python-scipy python-h5py python-pyresample  

# Dependencies for PolSARPro
apt-get install --yes bwidget itcl3 itk3 iwidgets4 libtk-img 

# Aria for automated ASF download
apt-get install --yes aria2 unrar

## LEDAPS
#apt-get install --yes zlib1g zlib1g-dev libtiff5 libtiff5-dev libgeotiff2 libgeotiff-dev libxml2 libxml2-dev ksh libhdf4-0 libhdf4-0-alt libhdf4-alt-dev libhdfeos0 libhdfeos-dev libgctp0d libgctp-dev hdf4-tools


#------------------------------------------------------------------
# 3 Download & Install non-repository Software and OSK
#------------------------------------------------------------------

mkdir ${HOME}/github
cd ${HOME}/github

# OpenSARKit
git clone https://github.com/BuddyVolly/OpenSARKit

#ASF Mapready
git clone https://github.com/asfadmin/ASF_MapReady
cd ${HOME}/github/ASF_MapReady
./configure --prefix=${HOME}/github/OpenSARKit/Programs/ASF_bin
make
make install

# PolSARPro
mkdir -p ${HOME}/github/OpenSARKit/Programs/ # not in new version 
mkdir -p ${HOME}/github/OpenSARKit/Programs/PolSARPro504
cd ${HOME}/github/OpenSARKit/Programs/PolSARPro504
wget https://earth.esa.int/documents/653194/1960708/PolSARpro_v5.0.4_Linux_20150607

unrar x PolSARpro_v5.0.4_Linux_20150607
cd Soft
bash Compil_PolSARpro_v5_Linux.bat 

# SNAP
mkdir ${HOME}/github/OpenSARKit/Programs/S1TBX
cd ${HOME}/github/OpenSARKit/Programs/S1TBX
wget http://sentinel1.s3.amazonaws.com/1.0/s1tbx_1.1.1_Linux64_installer.sh
sh s1tbx_1.1.1_Linux64_installer.sh

# add source file to .bashrc
echo "source ${HOME}/github/OpenSARKit/OpenSARKit_source.bash" >> ${HOME}/.bashrc

chmod -R 755 ${HOME}/github
chown -r ${USER}:${USER} ${HOME}/github
