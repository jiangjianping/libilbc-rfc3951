# here are the file names and urls for the technical specification
technical_spec = rfc3951.txt
success_marker = ../src/iLBC_define.h
BUILT_SOURCES = $(success_marker)

copy-spec:
	if [ ! -f "$(technical_spec)" ]; then cp -r $(abs_srcdir)/$(technical_spec) $(technical_spec); fi


# cleaning up in ../src is necessary because the awk script appends
$(success_marker): copy-spec
	cd ../src; rm *.c *.h &> /dev/null; $(AWK) -f $(abs_srcdir)/extract-cfile.awk \
		$(CURDIR)/$(technical_spec) > /dev/null

DISTCLEANFILES = $(BUILT_SOURCES)
