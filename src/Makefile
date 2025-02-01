SRC_FILES = reverse_bytes.vhd BCD_Multiplier_2.vhd Double_Odd_Positions.vhd compute_sum.vhd Luhn_Validator.vhd Card_Verifier.vhd Card_Verifier_tb.vhd
TOP_ENTITY = Card_Verifier_tb
WAVE_FILE = output.ghw

all: compile elaborate run view

compile:
	ghdl -a $(SRC_FILES)

elaborate:
	ghdl -e $(TOP_ENTITY)

run:
	ghdl -r $(TOP_ENTITY) --wave=$(WAVE_FILE)

view:
	gtkwave $(WAVE_FILE) &

clean:
	rm -f *.o *.cf $(TOP_ENTITY) $(WAVE_FILE)
