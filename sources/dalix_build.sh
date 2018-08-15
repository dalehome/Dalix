#!/bin/bash
# declare STRING variable
STRING="Dalix Builder"
#print variable on a screen
echo $STRING
sleep 2
#Prepare Parser for compilation
#perl Makefile.PL &&
#Prepare for compilation
echo "*** Prepare ***"
time ./configure --prefix=/usr &&
sleep 1
#Compile the package using 2 processor cores
echo "*** Make ***"
time make -j2 &&
sleep 1
#Test the Build
echo "*** Test ***"
time make check &&
sleep 1
#Install the package
echo "*** Install ***"
time make install &&
echo ""
echo "Done... woo hoo!!"