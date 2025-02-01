SRC_FILES = src/reverse_bytes.vhd src/BCD_Multiplier_2.vhd src/Double_Odd_Positions.vhd src/compute_sum.vhd src/Luhn_Validator.vhd src/Card_Verifier.vhd test/reverse_bytes_tb.vhd test/BCD_Multiplier_2_tb.vhd test/Double_Odd_Positions_tb.vhd test/compute_sum_tb.vhd test/Luhn_Validator_tb.vhd test/Card_Verifier_tb.vhd
TOP_ENTITY = reverse_bytes_tb
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
