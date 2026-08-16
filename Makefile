IVERILOG := iverilog
VVP := vvp
RTL := rtl/*.v
TB_DIR := tb
VVP_DIR := build/vvp
VCD_DIR := build/vcd

.PHONY: all dirs bubble controle clean

all: bubble

dirs:
	mkdir -p $(VVP_DIR) $(VCD_DIR)

bubble: dirs
	$(IVERILOG) -g2012 -o $(VVP_DIR)/processadorBubbleSortTB.vvp $(RTL) $(TB_DIR)/processadorBubbleSortTB.v
	$(VVP) $(VVP_DIR)/processadorBubbleSortTB.vvp

controle: dirs
	$(IVERILOG) -g2012 -o $(VVP_DIR)/controleTB.vvp rtl/controle.v $(TB_DIR)/controleTB.v
	$(VVP) $(VVP_DIR)/controleTB.vvp

clean:
	rm -f $(VVP_DIR)/*.vvp $(VCD_DIR)/*.vcd
