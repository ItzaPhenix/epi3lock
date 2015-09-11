INSTALL=install
PREFIX=/usr
SYSCONFDIR=/etc
PKG_CONFIG=pkg-config

OUT=epi3lock

# Check if pkg-config is installed, we need it for building CFLAGS/LIBS
ifeq ($(shell which $(PKG_CONFIG) 2>/dev/null 1>/dev/null || echo 1),1)
$(error "$(PKG_CONFIG) was not found")
endif

CFLAGS += -std=c99
CFLAGS += -pipe
CFLAGS += -Wall
CPPFLAGS += -D_GNU_SOURCE
CFLAGS += $(shell $(PKG_CONFIG) --cflags cairo xcb-dpms xcb-xinerama xcb-atom xcb-image xcb-xkb xkbcommon xkbcommon-x11)
LIBS += $(shell $(PKG_CONFIG) --libs cairo xcb-dpms xcb-xinerama xcb-atom xcb-image xcb-xkb xkbcommon xkbcommon-x11)
LIBS += -lpam
LIBS += -lev
LIBS += -lm

FILES:=$(wildcard *.c)
FILES:=$(FILES:.c=.o)

VERSION:=$(shell git describe --tags --abbrev=0)
GIT_VERSION:="$(shell git describe --tags --always) ($(shell git log --pretty=format:%cd --date=short -n1))"
CPPFLAGS += -DVERSION=\"${GIT_VERSION}\"

TARBALL=${OUT}-${VERSION}.tar.bz2

.PHONY: install clean uninstall

all: ${OUT}

${OUT}: ${FILES}
	$(CC) $(LDFLAGS) -o $@ $^ $(LIBS)

clean:
	rm -f ${OUT} ${FILES} ${OUT}-${VERSION}.tar.gz

install: all
	$(INSTALL) -d $(DESTDIR)$(PREFIX)/bin
	$(INSTALL) -d $(DESTDIR)$(SYSCONFDIR)/pam.d
	$(INSTALL) -m 755 ${OUT} $(DESTDIR)$(PREFIX)/bin/${OUT}
	$(INSTALL) -m 644 ${OUT}.pam $(DESTDIR)$(SYSCONFDIR)/pam.d/${OUT}

uninstall:
	rm -f $(DESTDIR)$(PREFIX)/bin/${OUT}

export:
	git archive HEAD --prefix=${OUT}-${VERSION} | bzip2 > ${TARBALL}

dist: clean
	[ ! -d ${OUT}-${VERSION} ] || rm -rf ${OUT}-${VERSION}
	[ ! -e ${OUT}-${VERSION}.tar.bz2 ] || rm ${OUT}-${VERSION}.tar.bz2
	mkdir ${OUT}-${VERSION}
	cp *.c *.h ${OUT}.1 ${OUT}.pam Makefile LICENSE README.md CHANGELOG ${OUT}-${VERSION}
	sed -e 's/^GIT_VERSION:=\(.*\)/GIT_VERSION:=$(shell /bin/echo '${GIT_VERSION}' | sed 's/\\/\\\\/g')/g;s/^VERSION:=\(.*\)/VERSION:=${VERSION}/g' Makefile > ${OUT}-${VERSION}/Makefile
	tar cfj ${OUT}-${VERSION}.tar.bz2 ${OUT}-${VERSION}
	rm -rf ${OUT}-${VERSION}
