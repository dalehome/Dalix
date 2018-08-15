#!/bin/bash
# declare STRING variable
STRING="Dalix Builder: automake and Xz"
#print variable on a screen
echo $STRING
echo ""
sleep 2
#Prepare Parser for compilation
#perl Makefile.PL &&
#Prepare for compilation
time ./configure --prefix=/usr --docdir=/usr/share/doc/automake-1.15.1 &&
sleep 1

#Compile the package using 2 processor cores
echo "*** Make ***"
time make -j2 &&
sleep 1

#A couple of tests link to wrong flex library - fix
sed -i "s:./configure:LEXLIB=/usr/lib/libfl.a &:" t/lex-{clean,depend}-cxx.sh &&
sleep 1 

#Test the Build
echo "*** Test ***"
time make -j4 check &&
sleep 1

#Install the package
echo "*** Install ***"
time make install &&
echo ""
echo "Done autoconf... woo hoo!!"

echo ""
echo "CTRL-C to quit"
sleep 10
echo ""
echo "Starting Xz build"

#Cleanup
cd .. &&
rm -rvf automake-1.15.1 &&
tar xvf xz-5.2.3.tar.xz &&
cd xz-5.2.3 &&

#Prepare for compilation
time ./configure --prefix=/usr    \
            --disable-static \
            --docdir=/usr/share/doc/xz-5.2.3 &&
sleep 5

#Compile the package using 2 processor cores
echo "*** Make ***"
time make -j2 &&
sleep 1

#Test the Build
echo "*** Test ***"
time make check &&
sleep 1

#Install the package
make install &&
mv -v   /usr/bin/{lzma,unlzma,lzcat,xz,unxz,xzcat} /bin &&
mv -v /usr/lib/liblzma.so.* /lib &&
ln -svf ../../lib/$(readlink /usr/lib/liblzma.so) /usr/lib/liblzma.so &&
echo ""
echo "Done xz... woo hoo!!"
echo ""
echo ""

#Final Check
find / -name automake
find / -name xz
find / -name lzma

