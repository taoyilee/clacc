/*

MIT License

Copyright (c) 2017 Michael (Tao-Yi) Lee

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

*/

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
	output wire [2*SIZE-1 : 0] pdt;
	reg [SIZE-1 : 0] a_int, b_int;
	reg [2*SIZE-1 : 0] pdt_int [LVL-1 : 0];
	integer i;

	assign pdt = pdt_int [LVL-1];

	always @ (posedge clk)
	begin
	// registering input of the multiplier
		a_int <= a;
		b_int <= b;
		for(i=1; i <LVL ; i = i + 1)
			pdt_int[i] <= pdt_int [i-1];
		pdt_int[0] <= a_int * b_int;
	end // always @ (posedge clk)
endmodule // pipelined_multiplier
