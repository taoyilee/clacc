`define CYCLE      30
`define SDFFILE    "./IPF.sdf"	  
`define End_CYCLE  10000000

`define PAT        "./pattern.dat"    
`define EXP0        "./golden0.dat"
   
`define EXP1        "./golden1.dat"     
    
`define EXP2        "./golden2.dat"

/*

MIT License

Copyright (c) 2017 Michael (Tao-Yi) Lee

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

*/


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
