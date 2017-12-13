`define CYCLE      30
`define SDFFILE    "./IPF.sdf"	  
`define End_CYCLE  10000000

`define PAT        "./pattern.dat"    
`define EXP0        "./golden0.dat"
   
`define EXP1        "./golden1.dat"     
    
`define EXP2        "./golden2.dat"


module clacc_mem (ipf_valid, ipf_data, ipf_addr, clk);

	input	ipf_valid;
	input	[13:0] ipf_addr;
	input	[7:0]  ipf_data;
	input	clk;

	reg [7:0] ipf_M [0:16383];
	integer i;

	initial begin
		for (i=0; i<=16383; i=i+1) ipf_M[i] = 0;
	end

	always@(negedge clk) 
		if (ipf_valid) ipf_M[ ipf_addr ] <= ipf_data;

endmodule
