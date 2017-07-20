#
#       NOTE: For now, to build for Android, use
#
#                make OSTYPE=android MACHTYPE=x86_64 COMPILERVARIANT= WFLAGS=
#
CONFIGPATH      = /Users/Hippo/compiler/libflex
COMPILERVARIANT = .clang
include		$(CONFIGPATH)/config.$(OSTYPE)-$(MACHTYPE)$(COMPILERVARIANT)

TARGET		= libflex-$(OSTYPE).a

#CC		= llvm-gcc #clang					#llvm-gcc
#LD		= llvm-gcc #clang					#llvm-gcc
#AR		= ar #llvm-ar				#ar
LINT		= /usr/local/bin/splint

INCDIRS		= -I.
OPTFLAGS	= -O3 #-emit-llvm
DBGFLAGS	= #-g
WFLAGS		= #-Wall -Werror
CFLAGS		= $(PLATFORM_DBGFLAGS) $(PLATFORM_CFLAGS) $(PLATFORM_DFLAGS) $(PLATFORM_OPTFLAGS) -DFLEX64 $(INCDIRS)#-emit-llvm -DFLEX64 $(INCDIRS)	#-DFLEX64 $(INCDIRS)

LIBOBJS	=\
	flex-$(OSTYPE).$(OBJECTEXTENSION)\
	flextoken.$(OBJECTEXTENSION)\
	flexmalloc.$(OBJECTEXTENSION)\

HEADERS	=\
	flexerror.h\
	flex.h\

all:	libsets-$(TARGET).a

libsets-$(TARGET).a: Makefile $(LIBOBJS)
	$(AR) r $(TARGET) $(LIBOBJS)

%.$(OBJECTEXTENSION): %.c $(HEADERS) Makefile
#	$(LINT) $(INCDIRS) $<
	$(CC) $(CFLAGS) $(WFLAGS) $(DBGFLAGS) $(OPTFLAGS) -c $<

flexversion.h: $(HEADERS) Makefile
	echo 'char FLEX_VERSION[] = "0.0-alpha (build '`date '+%m-%d-%Y-%H:%M:%S'`-`whoami`@`hostname`-`uname`\)\"\; > flexversion.h

clean:
	rm -f $(TARGET) $(LIBOBJS)
