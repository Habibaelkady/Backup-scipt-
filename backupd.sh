#!/bin/bash
main=$1
copy=$2
secs=$3
max=$4
#cd lab2_6816
if [ $# -ne 4 ];
then echo "please enter 4 parameters " >&2; exit 1
fi 
if [ ! -d $main ]
then echo "please enter an existing directory"  >&2; exit 1
fi
if ! [[ $secs =~ ^[0-9]+$ ]] ;
then echo "please enter a number for checking time"  >&2; exit 1
fi 
if ! [[ $max =~ ^[0-9]+$ ]] ;
then echo "please enter a number for maximum backupdir"  >&2; exit 1
fi 
new="backupdir$(date +%d-%m-%Y-%T)"
ls -lr $main > directory.info.last
cd $copy
cond=$(ls -1 | wc -l)
cd ..
if [ $cond -ge $4 ]
then 
cd $copy
remove=$(ls -1 | head -n 1)
rm -r $remove
cd ..
fi 
cp -r $main $copy/$new
while true
do 
sleep $secs 
ls -lr $main > directory.info.new
if cmp -s directory.info.last directory.info.new
then 
echo "there is no change"
else
cd $copy
cond=$(ls -1 | wc -l)
cd ..
echo "$cond"
if [ $cond -lt $4 ]
then 
echo "there is a change"
new="backupdir$(date +%d-%m-%Y-%T)"
cp -r $main $copy/$new
ls -lr $main > directory.info.last
else
cd $copy
remove=$(ls -1 | head -n 1)
rm -r $remove
cd ..
fi 
fi
done
