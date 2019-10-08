# sh@sighup.ch

OUTFILE := rom.smc
LDCONFIG := snes.cfg

AS := ca65
CC := cc65
LD := cl65

SPC700AS := dosbox -conf tools/tasm/dosbox.conf 2>&1 > /dev/null

ASFLAGS := -sir -g
CFLAGS := -Osir -g -I include --cpu 65816 -DRELEASE_BUILD
LDFLAGS :=  -Ln out/VICE

MKDIR_P = mkdir -p

MAPFILE := out/linker.map

OBJECTS := \
		out/startup.o		\
		out/hdr.o			\
		out/utils.o			\
		out/core.o			\
		out/slots.o			\
		out/slot0.o			\
		out/slot1.o			\
		out/snes_funcs.o		\
		out/snesfuncs.o		\
		out/snd_utils.o		\
		out/data.o 

.PHONY:	directories snd data release

all: directories snd $(OBJECTS) 
	$(LD) $(LDFLAGS) -m $(MAPFILE) -C $(LDCONFIG) -o out/$(OUTFILE) $(OBJECTS)
	ucon64 -smc -o out/ --chk -nbak out/$(OUTFILE) &> /dev/null
	sort out/VICE > out/VICE.sort

release:
	cp out/$(OUTFILE) release/$(basename $(OUTFILE))-$(shell git rev-parse --short HEAD).smc

directories:
	$(MKDIR_P) release

snd:
	@echo $(PATH)
#	$(SPC700AS)

out/%.o: src/%.s
	$(AS) $(ASFLAGS) -g -o $@ $<

out/%.o: lib/%.s
	$(AS) $(ASFLAGS) -g -o $@ $< 
		
out/%.o: data/%.s
	$(AS) $(ASFLAGS) -g -o $@ $<

out/%.s: src/%.c
	$(CC) $(CFLAGS) -g -o $@ $<

out/%.s: src/slots/%.c
	$(CC) $(CFLAGS) -g -o $@ $<

out/%.s: lib/%.c 
	$(CC) $(CFLAGS) -g -o $@ $<

clean: snd_clean
	rm -f out/*

snd_clean:
	rm -f snd/*.{LST,OBJ}
