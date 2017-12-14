HEAD		= ../header.v

VLOG		=ncverilog

SRC_FIFO			= dual_clock_fifo_tb.v ../dual_clock_fifo.v fifo_tester.v fifo_writer.v fifo_reader.v
SRC_PE			= dual_clock_fifo_tb.v ../dual_clock_fifo.v fifo_tester.v fifo_writer.v fifo_reader.v
SRC_MULT			= ../header.v mult_pipe2_tb.v ../mult_pipe2.v

VLOGARG		=+access+r

TMPFILE		=*.log\
			 INCA_libs

RM			=-rm -rf

all :: test_fifo test_pe test_mult
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
