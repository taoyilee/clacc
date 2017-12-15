HEAD		= ../header.v

VLOG		=ncverilog

SRC_FIFO			= dual_clock_fifo_tb.v ../dual_clock_fifo.v fifo_tester.v fifo_writer.v fifo_reader.v
SRC_PE			= dual_clock_fifo_tb.v ../dual_clock_fifo.v fifo_tester.v fifo_writer.v fifo_reader.v
SRC_MULT			= ../header.v mult_pipe2_tb.v ../mult_pipe2.v
SRC_IFMAP_SPAD			= ../header.v ifmap_spad_tb.v ../ifmap_spad.v
SRC_BS_ADD		= ../header.v bs_adder_tb.v ../bs_adder.v ../fa.v ../ha.v
SRC_BS_MUL		= ../header.v bs_adder_tb.v ../bs_mult.v ../bs_mult_slice.v ../counter_5to3.v

VLOGARG		=+access+r

TMPFILE		=*.log\
			 INCA_libs

RM			=-rm -rf

all :: test_fifo test_pe test_mult
test_bs_adder :
		$(VLOG) $(HEAD) $(SRC_BS_ADD) $(VLOGARG) $(MODE0)
test_bs_mult :
		$(VLOG) $(HEAD) $(SRC_BS_MUL) $(VLOGARG) $(MODE0)
test_ifmap_spad :
		$(VLOG) $(HEAD) $(SRC_IFMAP_SPAD) $(VLOGARG) $(MODE0)
test_mult :
		$(VLOG) $(HEAD) $(SRC_MULT) $(VLOGARG) $(MODE0)
test_fifo :
		$(VLOG) $(HEAD) $(SRC_FIFO) $(VLOGARG) $(MODE0)
test_pe :
		$(VLOG) $(HEAD) $(SRC_PE) $(VLOGARG) $(MODE0)

check :
		$(VLOG) -c $(SRC)
clean :
		$(RM) $(TMPFILE)
