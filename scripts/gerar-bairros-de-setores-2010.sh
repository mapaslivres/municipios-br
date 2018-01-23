# !/bin/bash

SHAPE_ENCODING="ISO-8859-1"
FORMAT_NAME="GeoJSON";
SOURCE_DIR=./data/ibge-censo-2010-setores-censitarios
TARGET_DIR=./data/bairros-ibge-2010

# create target diretory
mkdir -p $TARGET_DIR

# helper arrays for filenames
declare -a stateNumbers=( "11" "12" "13" "15" "16" "17" "21" "22" "23" "24" "25" "26" "27" "28" "29" "31" "32" "33" "35" "41" "42" "43" "50" "51" "52" "53" )
declare -a stateCodes=( "ro" "ac" "am" "pa" "ap" "to" "ma" "pi" "ce" "rn" "pb" "pe" "al" "se" "ba" "mg" "es" "rj" "sp" "pr" "sc" "rs" "ms" "mt" "go" "df")
stateLength=${#stateNumbers[@]}

for (( i=1; i<${stateLength}+1; i++ ));
do
  rm $TARGET_DIR/${stateCodes[$i-1]}.geojson
  ogr2ogr -f "GeoJSON" $TARGET_DIR/${stateCodes[$i-1]}.geojson /vsizip/$SOURCE_DIR/${stateCodes[$i-1]}_setores_censitarios.zip/${stateNumbers[$i-1]}SEE250GC_SIR.shp -dialect sqlite -sql "select BuildArea(ST_ExteriorRing(st_unaryunion(st_collect((Geometry))))),CD_GEOCODB,NM_BAIRRO from '${stateNumbers[$i-1]}SEE250GC_SIR' WHERE CD_GEOCODB IS NOT NULL GROUP BY CD_GEOCODB"
done


"11" "12" "13" "15" "16" "17" "21" "22" "23" "24" "25" "26" "27" "28" "29" "31" "32" "33" "35" "41" "42" "43" "50" "51" "52" "53" 
"RO" "AC" "AM" "PA" "AP" "TO" "MA" "PI" "CE" "RN" "PB" "PE" "AL" "SE" "BA" "MG" "ES" "RJ" "SP" "PR" "SC" "RS" "MS" "MT" "GO" "DF" 
# Parse
function downloadSectors {
  local statePrefix
  statePrefix=$(echo "$1" | tr '[:upper:]' '[:lower:]');
  mkdir -p $DATA_DIR;

  (cd $DATA_DIR; wget --continue \
       -nd  \
       --recursive -A "$statePrefix*setores_censitarios.zip" $FTP_URL;)
}
echo $DATA_DIR

# downloadSectors;

# ogr2ogr -f $FORMAT_NAME ./data/teste.geojson /vsizip/$DATA_DIR/$statePrefix_setores_censitarios.zip/27SEE250GC_SIR.shp -dialect sqlite -sql "select BuildArea(ST_ExteriorRing(st_unaryunion(st_collect((Geometry))))),CD_GEOCODB,NM_BAIRRO from '27SEE250GC_SIR' WHERE CD_GEOCODB IS NOT NULL GROUP BY CD_GEOCODB"

ogr2ogr -f "GeoJSON" ./sp.geojson /vsizip/./data/ibge-censo-2010-setores-censitarios/sp_setores_censitarios.zip/35SEE250GC_SIR.shp -dialect sqlite -sql "select BuildArea(ST_ExteriorRing(st_unaryunion(st_collect((Geometry))))),CD_GEOCODB,NM_BAIRRO from '35SEE250GC_SIR' WHERE CD_GEOCODB IS NOT NULL GROUP BY CD_GEOCODB"


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
