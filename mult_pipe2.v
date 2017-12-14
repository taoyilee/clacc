module mult_pipe2 #(
	parameter SIZE = 16,
	parameter LVL = 2
)
( a, b, clk, pdt) ;
/*
* parameter 'SIZE' is the width of multiplier/multiplicand;.Application Notes 10-5
* parameter '' is the intended number of stages of the
* pipelined multiplier;
* which is typically the smallest integer greater than or equal
* to base 2 logarithm of 'SIZE'
*/
	input [SIZE-1 : 0] a;
	input [SIZE-1 : 0] b;
	input clk;
	output [2*SIZE-1 : 0] pdt;
	reg [SIZE-1 : 0] a_int, b_int;
	reg [2*SIZE-1 : 0] pdt_int [LVL-1 : 0];
	integer i;

	assign pdt = pdt_int [LVL-1];

	always @ (posedge clk)
	begin
	// registering input of the multiplier
		a_int <= a;
		b_int <= b;
	// '' levels of registers to be inferred at the output
	// of the multiplier
		pdt_int[0] <= a_int * b_int;
		for(i =1;i < LVL ;i =i +1)
			pdt_int [i] <= pdt_int [i-1];
	end // always @ (posedge clk)
endmodule // pipelined_multiplier
