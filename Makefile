SRC_FILES := $(shell bzr inventory)
VERSION := 0.$(shell bzr revno)
DISTNAME = xfn-spider-${VERSION}
TARNAME = ${DISTNAME}.tar.gz

dist : distclean
	mkdir -p dist/${DISTNAME}; cp ${SRC_FILES} dist/${DISTNAME}
	tar -zc -C dist -f ${TARNAME} ${DISTNAME}; rm -fr dist
.PHONY : distclean
distclean :
	rm -fr dist
	rm -f *.tar.gz