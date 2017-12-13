HEAD		=header.v

VLOG		=ncverilog

SRC			=CLA_tb.v\
			 CLA.v

SRC_syn 	=CLA_tb.v\
			 CLA_syn.v\
			 -v /theda21_2/CBDK_IC_Contest/cur/Verilog/tsmc13.v
			 		 
SDF			=+define+SDF

MODE0		=+define+MODE0

MODE1		=+define+MODE1

MODE2		=+define+MODE2

VLOGARG		=+access+r

TMPFILE		=*.log\
			 INCA_libs

RM			=-rm -rf

all :: sim
sim :
		$(VLOG) $(HEAD) $(SRC) $(VLOGARG) $(MODE0)

sim1 :
		$(VLOG) $(HEAD) $(SRC) $(VLOGARG) $(MODE1)

sim2 :
		$(VLOG) $(HEAD) $(SRC) $(VLOGARG) $(MODE2)

syn : 
		$(VLOG) $(HEAD) $(SRC_syn) $(SDF) $(VLOGARG) $(MODE0)

syn1 :
		$(VLOG) $(HEAD) $(SRC_syn) $(SDF) $(VLOGARG) $(MODE1)

syn2 :
		$(VLOG) $(HEAD) $(SRC_syn) $(SDF) $(VLOGARG) $(MODE2)

check :
		$(VLOG) -c $(SRC)
clean :
		$(RM) $(TMPFILE)
