
  time { ./configure --prefix=/usr && make -j2 && make -C libelf install && install -vm644 config/libelf.pc /usr/lib/pkgconfig; }


   time { ./configure --prefix=/usr --disable-static && make -j2 && make check && make install ; }


  time {  make -j2 && make check && make install ; }
  
  
  time { ./configure --prefix=/usr --disable-static && make -j2 && make PERL5LIB=$PWD/tests/ check && make install ; }