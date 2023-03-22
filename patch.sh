#!/bin/bash
# Mohammad Fakhr Attar (MFA)
# Version: 1.0.1
# 11.03.2023

find / -type d \( -path /proc -o -path /run -o -path /sys -o -path /snap \) -prune -o -name 'tzdb.dat' -print | grep "/lib" | awk -F '/lib/tzdb.dat' '{print $1}' | awk -F '/jre' '{print $1}' | awk -F '/tzdb.dat' '{print $1}' > $(pwd)/jdk_dir.txt;

sed -i 's/^/export JAVA_HOME=/g' $(pwd)/jdk_dir.txt;

filename=$(pwd)/jdk_dir.txt;

while read line;
do
# for read each line

$line;

echo $($JAVA_HOME/bin/java -version);

STR01=$($JAVA_HOME/bin/java Time | grep "after new year - DST offset" | awk -F ': ' '{print $2}');
STR02=$($JAVA_HOME/bin/java Time | grep "before new year - DST offset:" | awk -F ': ' '{print $2}');

if [[ $STR01 != $STR02 ]]; then

       echo -e "JAVA need to update TimeZone..."

# update the tzdata from https://www.iana.org/time-zones/repository/tzdata-latest.tar.gz

echo Patching $JAVA_HOME

# sourceFile=file:///omidvar/jobs/timezone/runner/tzdata-2023_03_01.tar.gz

sourceFile=file://$(pwd)/tzdata-2023_03_01.tar.gz

echo create a backup
databaseFolder=$JAVA_HOME/lib;
# /tzdb.dat
if ! test -f "$databaseFolder/tzdb.dat"; then
    databaseFolder=$JAVA_HOME/jre/lib;
    if ! test -f "$databaseFolder/tzdb.dat"; then
        echo "$databaseFolder/tzdb.dat not exists."
        exit
    fi
fi

echo Before patch
ls -l $databaseFolder/tzdb.dat

cp $databaseFolder/tzdb.dat $databaseFolder/tzdb_back_$(($(date +%s%N)/1000000000)).dat

$JAVA_HOME/bin/java -jar tzupdater.jar -v -l $sourceFile

echo after patch
ls -l $databaseFolder/tzdb.dat;

STR03=$($JAVA_HOME/bin/java Time | grep "after new year - DST offset" | awk -F ': ' '{print $2}');
STR04=$($JAVA_HOME/bin/java Time | grep "before new year - DST offset:" | awk -F ': ' '{print $2}');

if [[ $STR03 != $STR04 ]]; then
  echo -e "\n\e[1;33m=================================================================\e[0m\n\e[1;33m|\e[0m  \e[0;36mexport\e[0m \e[1;35mJAVA_HOME\e[0m\e[1;36m=\e[0m\e[1;36m$JAVA_HOME\e[0m\t\e[1;33m|\e[0m\n\e[1;33m|\e[0m\t\t\t\t\t\t\t\t\e[1;33m|\e[0m\n\e[1;33m|\e[0m  \e[1;33mJAVA is\e[0m \e[1;31mNOT\e[0m \e[1;33mupdate TimeZone Accurately...\e[0m\t\t\t\e[1;33m|\e[0m\n\e[1;33m|\e[0m\t\t\t\t\t\t\t\t\e[1;33m|\e[0m\n\e[1;33m|\e[0m  You must Patch Again by \e[1;32mpatch.sh\e[0m or Patch \e[1;36mManually\e[0m by :\t\e[1;33m|\e[0m\n\e[1;33m|\e[0m\t\t\t\t\t\t\t\t\e[1;33m|\e[0m\n\e[1;33m|\e[0m\t\t  \e[1;31mtimezone-patcher-v1.0.zip\e[0m\t\t\t\e[1;33m|\e[0m\n\e[1;33m=================================================================\e[0m\n";
else
  echo -e "\e[1;35mJAVA_HOME\e[0m\e[1;36m=\e[0m\e[1;33m$JAVA_HOME\e[0m\n\n\e[1;33mJAVA\e[0m \"$JAVA_HOME\" \e[1;36mversion is update TimeZone\e[0m \e[1;32mSuccessfully\e[0m.\n\e[1;33m--------------------------------------------------------------------------\e[0m"
fi

else
  echo -e "\e[0;36mexport\e[0m \e[1;35mJAVA_HOME\e[0m\e[1;36m=\e[0m\e[1;36m$JAVA_HOME\e[0m\n\n\e[1;33mJAVA\e[0m \"$JAVA_HOME\" \e[1;33mversion is\e[0m \e[1;31mNOT\e[0m \e[1;33mneed to update TimeZone\e[0m.\n\e[1;33m--------------------------------------------------------------------------\e[0m"
fi

done < $filename;

rm -f $(pwd)/jdk_dir.txt;
