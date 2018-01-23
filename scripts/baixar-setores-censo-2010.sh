# !/bin/bash

################################################
# setores.sh - Command line utility for IBGE data
# 
# Install wget before running this script.
################################################
usage="setores <sector id pattern>";


FORMAT_NAME="ESRI Shapefile";
DATA_DIR=./data/ibge-censo-2010-setores-censitarios
FTP_URL=ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_de_setores_censitarios__divisoes_intramunicipais/censo_2010/setores_censitarios_shp/

# Parse options
# while getopts ":f:" opt; do
#   case $opt in
#     f ) FORMAT_NAME=$OPTARG;;
#     \? ) echo $usage
#           exit 1;;
#   esac
# done

# shift $(($OPTIND - 1));

# # Parameters
# pattern="$1";
# state=${pattern:0:2};

# TODO Check for valid formats

# Download sector's zipfiles
#
# params: $statePrefix - prefix of state to be downloaded
function downloadSectors {
  local statePrefix
  statePrefix=$(echo "$1" | tr '[:upper:]' '[:lower:]');
  mkdir -p $DATA_DIR;

  (cd $DATA_DIR; \
    wget --continue \
       -nd  \
       --recursive -A "$statePrefix*setores_censitarios.zip" $FTP_URL;
    wget --continue \ 
       -nd  \
       --recursive -A "$statePrefix*setores _censitarios.zip" $FTP_URL;) 
}
echo $DATA_DIR

downloadSectors;


# touch $DATA_DIR/teste.txt
# mkdir -p $DATA_DIR
# rm -rf "$DATA_DIR/$pattern.*"
# for zipfile in $DATA_DIR/source/*.zip;
# do
#   echo "Extracting sectors with id $pattern ...";
#   ogr2ogr -append  \
#     -where "CD_GEOCODI LIKE '$pattern%'" \
#     -t_srs EPSG:4326 \
#     $DATA_DIR/$pattern.shp \
#     /vsizip/${zipfile}
# done
