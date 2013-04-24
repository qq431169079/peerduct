all::

YAJL_DIR        = yajl
YAJL_BUILDDIR   = $(YAJL_DIR)/build/yajl-2.0.3
YAJL_LIBDIR     = $(YAJL_BUILDDIR)/lib
YAJL_INCDIR     = $(YAJL_BUILDDIR)/include
YAJL_LIB        = $(YAJL_LIBDIR)/libyajl_s.a

YAJL_LDFLAGS    = $(YAJL_LIB)
YAJL_CFLAGS     = -I$(YAJL_INCDIR)

obj-pd = main.o
obj-nd_reader = nd_reader.o nodes_dat.o peer.o
obj-test_list = list_test.o
TARGETS = pd nd_reader test_list nnode

cfg_json.o : $(YAJL_LIB)

obj-nnode = nnode.o cfg_json.o
cflags-nnode = $(YAJL_CFLAGS)
ldflags-nnode = $(YAJL_LDFLAGS) -lev

$(YAJL_LIB) :
	cd $(YAJL_DIR) && ./configure && $(MAKE) $(MAKEFLAGS)

yajl.clean : $(MAKE) $(MAKEFLAGS) -C $(YAJL_DIR) clean

dirclean: yajl.clean clean

include base.mk
