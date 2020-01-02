#!/bin/sh

WORK_DIR=`pwd`

echo "==================================================================================="
echo "INSTALL GNU PROLOG"
yum -y install gcc glibc.i686 gcc-c++ 
PROLOG_PACKAGE_NAME=$(grep PROLOG_PACKAGE_NAME $WORK_DIR/package_metadata.txt | sed 's/PROLOG_PACKAGE_NAME=//')
cd /opt
mkdir -p /opt/gprolog/gprolog_dist
cd /opt/gprolog
mv $WORK_DIR/$PROLOG_PACKAGE_NAME .
tar -zxvf $PROLOG_PACKAGE_NAME -C ./gprolog_dist
cd ./gprolog_dist/gprolog-*/src
./configure --with-install-dir=/opt/gprolog
make
make install
cd $WORK_DIR


echo "==================================================================================="
echo "INSTALL CHARLIE"
CHARLIE_PACKAGE_NAME=$(grep CHARLIE_PACKAGE_NAME $WORK_DIR/package_metadata.txt | sed 's/CHARLIE_PACKAGE_NAME=//')
cd /opt
mkdir -p /opt/charlie
mv $WORK_DIR/$CHARLIE_PACKAGE_NAME /opt/charlie
ext="tar.gz"
#jdk_version=8
#readonly url="http://www.oracle.com"
#readonly jdk_download_url1="$url/technetwork/java/javase/downloads/index.html"
#echo dlurl1=$jdk_download_url1
#readonly jdk_download_url2=$(
#    curl -s $jdk_download_url1 | \
#    egrep -o "\/technetwork\/java/\javase\/downloads\/jdk${jdk_version}-downloads-.+?\.html" | \
#    head -1 | cut -d '"' -f 1
#)
#echo dlurl2=$jdk_download_url2
#[[ -z "$jdk_download_url2" ]] && echo "Could not get jdk download url - $jdk_download_url1" >> /dev/stderr
#readonly jdk_download_url3="${url}${jdk_download_url2}"
#echo dlurl3=$jdk_download_url3
#readonly jdk_download_url4=$(curl -s $jdk_download_url3 | egrep -o "http\:\/\/download.oracle\.com\/otn-pub\/java\/jdk\/[7-8]u[0-9]+\-(.*)+\/jdk-[7-8]u[0-9]+(.*)linux-x64.$ext")
#echo dlurl4=$jdk_download_url4
#for dl_url in ${jdk_download_url4[@]}; do
#    wget --no-cookies \
#         --no-check-certificate \
#         --header "Cookie: oraclelicense=accept-securebackup-cookie" \
#         -N $dl_url
#done

jdk_version=${1:-8}
readonly url="https://www.oracle.com"
readonly jdk_download_url1="$url/technetwork/java/javase/downloads/index.html"
readonly jdk_download_url2=$(
    curl -s $jdk_download_url1 | \
    egrep -o "\/technetwork\/java/\javase\/downloads\/jdk${jdk_version}-downloads-.+?\.html" | \
    head -1 | \
    cut -d '"' -f 1
)
[[ -z "$jdk_download_url2" ]] && echo "Could not get jdk download url - $jdk_download_url1" >> /dev/stderr

readonly jdk_download_url3="${url}${jdk_download_url2}"
readonly jdk_download_url4=$(
    curl -s $jdk_download_url3 | \
    egrep -o "http\:\/\/download.oracle\.com\/otn-pub\/java\/jdk\/[8-9](u[0-9]+|\+).*\/jdk-${jdk_version}.*(-|_)linux-(x64|x64_bin).$ext"
)

for dl_url in ${jdk_download_url4[@]}; do
    wget --no-cookies \
         --no-check-certificate \
         --header "Cookie: oraclelicense=accept-securebackup-cookie" \
         -N $dl_url
done
JAVA_TARBALL=$(basename $dl_url)
tar xzfv $JAVA_TARBALL
cd /opt/charlie
tar -zxvf $CHARLIE_PACKAGE_NAME
cd $WORK_DIR


echo "==================================================================================="
echo "INSTALL LOLA"
yum -y install autoconf automake flex bison gengetopt make help2man kimwitu++
LOLA_PACKAGE_NAME=$(grep LOLA_PACKAGE_NAME $WORK_DIR/package_metadata.txt | sed 's/LOLA_PACKAGE_NAME=//')
cd /opt
mkdir -p /opt/lola/lola_dist
mv $WORK_DIR/$LOLA_PACKAGE_NAME /opt/lola
cd /opt/lola
tar -zxvf $LOLA_PACKAGE_NAME -C /opt/lola/lola_dist
cd /opt/lola/lola_dist/lola-*
./configure --prefix=/opt/lola
make
make install
cd $WORK_DIR

echo "==================================================================================="
echo "INSTALL TINA"
yum -y install glibc.i686 unzip
TINA_PACKAGE_NAME=$(grep TINA_PACKAGE_NAME $WORK_DIR/package_metadata.txt | sed 's/TINA_PACKAGE_NAME=//')
cd /opt
mkdir -p /opt/tina
mv $WORK_DIR/$TINA_PACKAGE_NAME /opt/tina
cd /opt/tina
tar -xzvf $TINA_PACKAGE_NAME
cd $WORK_DIR
