PROJECT=libftdispi

CC=gcc
DESTDIR?=/usr/local/lib
DESTDIR_H?=/usr/local/include

all:	ftdispi.so

ftdispi.so:
	$(CC) -fpic -shared ftdispi.c -o ftdispi.so -Wall

spitest: spitest.c ftdispi.so
	$(CC) spitest.c ftdispi.so -I. -lftdi -o spitest

.PHONY: clean

clean:
	find . -name '*.so' -exec rm -r {} \;
	rm spitest;


distclean:
	rm ${DESTDIR}/ftdispi.so;
	rm ${DESTDIR_H}/ftdispi.h;


doc:
	@mkdir -p share/doc
	@doxygen share/ftdispi/Doxyfile

install:
	cp -n ftdispi.so ${DESTDIR}
	cp -n ftdispi.h ${DESTDIR_H}

archive:
	@T=`git tag -l | tail -n 1`; git archive --format=tar --prefix=$(PROJECT)-$${T#v}/ $$T | bzip2 > ../$(PROJECT)-$${T#v}.tar.bz2
