# Build a simple single file assembly project with z88dk's z80asm

# tool paths
ZASM = $(ZASM_PATH)/zasm
MINIPRO = minipro

# flash or EPROM device for minipro - see "minipro -l" for options
ROM_IC = "SST39SF010A"

# target image - in this case we default to S-record format
BIN = tranz330_hellorld.s19

.PHONY: all clean


all:    $(BIN)

clean:
	rm -f *.s19 *.lst

flash: $(BIN)
	$(MINIPRO) -w $(BIN) -f srec -p $(ROM_IC) -E

burn: $(BIN)
	$(MINIPRO) -w $(BIN) -f srec -p $(ROM_IC)

%.s19: %.asm
	$(ZASM) --z80 -s -i $^ -o $@

