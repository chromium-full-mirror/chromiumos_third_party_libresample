CC ?= gcc

C_SRCS = src/filterkit.c src/resample.c src/resamplesubs.c
HEADERS = include/libresample.h src/config.h src/filterkit.h src/resample_defs.h

all: clean dirs resample_lib
	@echo "Done building."

clean:
	rm -rf libresample.a objs/

dirs:
	test -d objs/src || mkdir -p objs/src

C_OBJS = $(C_SRCS:%.c=objs/%.o)

$(C_OBJS): objs/%.o: %.c $(HEADERS)
	$(CC) -c $(CFLAGS) -fPIC -Iobjs/ $< -o $@

resample_lib: $(C_OBJS)
	ar rcs libresample.a \
	$(C_OBJS)
