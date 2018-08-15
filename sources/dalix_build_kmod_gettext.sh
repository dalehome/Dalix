#!/bin/bash
# declare STRING variable
STRING="Dalix Builder: kmod and gettext"
echo $STRING
echo ""
sleep 2
#Prepare Parser for compilation
#perl Makefile.PL &&
#Prepare for compilation
time ./configure --prefix=/usr          \
            --bindir=/bin          \
            --sysconfdir=/etc      \
            --with-rootlibdir=/lib \
            --with-xz              \
            --with-zlib &&
sleep 1

#Compile the package using 2 processor cores
echo "*** Make ***"
time make -j2 &&
sleep 1

#Install the package
echo "*** Install ***"
time make install &&

for target in depmod insmod lsmod modinfo modprobe rmmod; do
  ln -sfv ../bin/kmod /sbin/$target
done &&

ln -sfv kmod /bin/lsmod &&

echo ""
echo "Done kmod... woo hoo!!"

echo ""
echo "CTRL-C to quit"
sleep 10
echo ""
echo "Starting gettext build"

#Cleanup
cd .. &&
rm -rvf kmod-25 &&
tar xvf gettext-0.19.8.1.tar.xz &&
cd gettext-0.19.8.1 &&

#First, suppress two invocations of test-lock
sed -i '/^TESTS =/d' gettext-runtime/tests/Makefile.in &&
sed -i 's/test-lock..EXEEXT.//' gettext-tools/gnulib-tests/Makefile.in &&

#Prepare for compilation
time ./configure --prefix=/usr    \
            --disable-static \
            --docdir=/usr/share/doc/gettext-0.19.8.1 &&
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
chmod -v 0755 /usr/lib/preloadable_libintl.so
echo ""
echo "Done gettext... woo hoo!!"
echo ""
echo ""

#Final Check
find / -name gettext
find / -name msgen
find / -name kmod

