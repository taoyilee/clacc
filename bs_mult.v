/*

MIT License

Copyright (c) 2017 Michael (Tao-Yi) Lee

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

*/

module bs_mult(clk, x, y, p, firstbit, lastbit);
	input clk;
	input x, y, firstbit, lastbit;
	output p;
	assign xy = x & y;

	wire [29:0] pout;
	wire [30:0] rout;
	wire [30:0] cout;

	bs_mult_slice I0(.clk(clk), .xy(xy), .pin(pout[0]), .cin(1'b0), 
		.rin(firstbit), .x(x), .y(y), .pout(p), .cout(cout[0]), 
		.rout(rout[0]), .lastbit(lastbit));

	bs_mult_slice I1(.clk(clk), .xy(xy), .pin(pout[1]), .cin(cout[0]), 
		.rin(rout[0]), .x(x), .y(y), .pout(pout[0]), .cout(cout[1]), 
		.rout(rout[1]), .lastbit(lastbit));

	bs_mult_slice I2(.clk(clk), .xy(xy), .pin(pout[2]), .cin(cout[1]), 
		.rin(rout[1]), .x(x), .y(y), .pout(pout[1]), .cout(cout[2]), 
		.rout(rout[2]), .lastbit(lastbit));

	bs_mult_slice I3(.clk(clk), .xy(xy), .pin(pout[3]), .cin(cout[2]), 
		.rin(rout[2]), .x(x), .y(y), .pout(pout[2]), .cout(cout[3]), 
		.rout(rout[3]), .lastbit(lastbit));

	bs_mult_slice I4(.clk(clk), .xy(xy), .pin(pout[4]), .cin(cout[3]), 
		.rin(rout[3]), .x(x), .y(y), .pout(pout[3]), .cout(cout[4]), 
		.rout(rout[4]), .lastbit(lastbit));

	bs_mult_slice I5(.clk(clk), .xy(xy), .pin(pout[5]), .cin(cout[4]), 
		.rin(rout[4]), .x(x), .y(y), .pout(pout[4]), .cout(cout[5]), 
		.rout(rout[5]), .lastbit(lastbit));

	bs_mult_slice I6(.clk(clk), .xy(xy), .pin(pout[6]), .cin(cout[5]), 
		.rin(rout[5]), .x(x), .y(y), .pout(pout[5]), .cout(cout[6]), 
		.rout(rout[6]), .lastbit(lastbit));

	bs_mult_slice I7(.clk(clk), .xy(xy), .pin(pout[7]), .cin(cout[6]), 
		.rin(rout[6]), .x(x), .y(y), .pout(pout[6]), .cout(cout[7]), 
		.rout(rout[7]), .lastbit(lastbit));

	bs_mult_slice I8(.clk(clk), .xy(xy), .pin(pout[8]), .cin(cout[7]), 
		.rin(rout[7]), .x(x), .y(y), .pout(pout[7]), .cout(cout[8]), 
		.rout(rout[8]), .lastbit(lastbit));

	bs_mult_slice I9(.clk(clk), .xy(xy), .pin(pout[9]), .cin(cout[8]), 
		.rin(rout[8]), .x(x), .y(y), .pout(pout[8]), .cout(cout[9]), 
		.rout(rout[9]), .lastbit(lastbit));

	bs_mult_slice I10(.clk(clk), .xy(xy), .pin(pout[10]), .cin(cout[9]), 
		.rin(rout[9]), .x(x), .y(y), .pout(pout[9]), .cout(cout[10]), 
		.rout(rout[10]), .lastbit(lastbit));

	bs_mult_slice I11(.clk(clk), .xy(xy), .pin(pout[11]), .cin(cout[10]), 
		.rin(rout[10]), .x(x), .y(y), .pout(pout[10]), .cout(cout[11]), 
		.rout(rout[11]), .lastbit(lastbit));

	bs_mult_slice I12(.clk(clk), .xy(xy), .pin(pout[12]), .cin(cout[11]), 
		.rin(rout[11]), .x(x), .y(y), .pout(pout[11]), .cout(cout[12]), 
		.rout(rout[12]), .lastbit(lastbit));

	bs_mult_slice I13(.clk(clk), .xy(xy), .pin(pout[13]), .cin(cout[12]), 
		.rin(rout[12]), .x(x), .y(y), .pout(pout[12]), .cout(cout[13]), 
		.rout(rout[13]), .lastbit(lastbit));

	bs_mult_slice I14(.clk(clk), .xy(xy), .pin(pout[14]), .cin(cout[13]), 
		.rin(rout[13]), .x(x), .y(y), .pout(pout[13]), .cout(cout[14]), 
		.rout(rout[14]), .lastbit(lastbit));

	bs_mult_slice I15(.clk(clk), .xy(xy), .pin(pout[15]), .cin(cout[14]), 
		.rin(rout[14]), .x(x), .y(y), .pout(pout[14]), .cout(cout[15]), 
		.rout(rout[15]), .lastbit(lastbit));

	bs_mult_slice I16(.clk(clk), .xy(xy), .pin(pout[16]), .cin(cout[15]), 
		.rin(rout[15]), .x(x), .y(y), .pout(pout[15]), .cout(cout[16]), 
		.rout(rout[16]), .lastbit(lastbit));

	bs_mult_slice I17(.clk(clk), .xy(xy), .pin(pout[17]), .cin(cout[16]), 
		.rin(rout[16]), .x(x), .y(y), .pout(pout[16]), .cout(cout[17]), 
		.rout(rout[17]), .lastbit(lastbit));

	bs_mult_slice I18(.clk(clk), .xy(xy), .pin(pout[18]), .cin(cout[17]), 
		.rin(rout[17]), .x(x), .y(y), .pout(pout[17]), .cout(cout[18]), 
		.rout(rout[18]), .lastbit(lastbit));

	bs_mult_slice I19(.clk(clk), .xy(xy), .pin(pout[19]), .cin(cout[18]), 
		.rin(rout[18]), .x(x), .y(y), .pout(pout[18]), .cout(cout[19]), 
		.rout(rout[19]), .lastbit(lastbit));

	bs_mult_slice I20(.clk(clk), .xy(xy), .pin(pout[20]), .cin(cout[19]), 
		.rin(rout[19]), .x(x), .y(y), .pout(pout[19]), .cout(cout[20]), 
		.rout(rout[20]), .lastbit(lastbit));

	bs_mult_slice I21(.clk(clk), .xy(xy), .pin(pout[21]), .cin(cout[20]), 
		.rin(rout[20]), .x(x), .y(y), .pout(pout[20]), .cout(cout[21]), 
		.rout(rout[21]), .lastbit(lastbit));

	bs_mult_slice I22(.clk(clk), .xy(xy), .pin(pout[22]), .cin(cout[21]), 
		.rin(rout[21]), .x(x), .y(y), .pout(pout[21]), .cout(cout[22]), 
		.rout(rout[22]), .lastbit(lastbit));

	bs_mult_slice I23(.clk(clk), .xy(xy), .pin(pout[23]), .cin(cout[22]), 
		.rin(rout[22]), .x(x), .y(y), .pout(pout[22]), .cout(cout[23]), 
		.rout(rout[23]), .lastbit(lastbit));

	bs_mult_slice I24(.clk(clk), .xy(xy), .pin(pout[24]), .cin(cout[23]), 
		.rin(rout[23]), .x(x), .y(y), .pout(pout[23]), .cout(cout[24]), 
		.rout(rout[24]), .lastbit(lastbit));

	bs_mult_slice I25(.clk(clk), .xy(xy), .pin(pout[25]), .cin(cout[24]), 
		.rin(rout[24]), .x(x), .y(y), .pout(pout[24]), .cout(cout[25]), 
		.rout(rout[25]), .lastbit(lastbit));

	bs_mult_slice I26(.clk(clk), .xy(xy), .pin(pout[26]), .cin(cout[25]), 
		.rin(rout[25]), .x(x), .y(y), .pout(pout[25]), .cout(cout[26]), 
		.rout(rout[26]), .lastbit(lastbit));

	bs_mult_slice I27(.clk(clk), .xy(xy), .pin(pout[27]), .cin(cout[26]), 
		.rin(rout[26]), .x(x), .y(y), .pout(pout[26]), .cout(cout[27]), 
		.rout(rout[27]), .lastbit(lastbit));

	bs_mult_slice I28(.clk(clk), .xy(xy), .pin(pout[28]), .cin(cout[27]), 
		.rin(rout[27]), .x(x), .y(y), .pout(pout[27]), .cout(cout[28]), 
		.rout(rout[28]), .lastbit(lastbit));

	bs_mult_slice I29(.clk(clk), .xy(xy), .pin(pout[29]), .cin(cout[28]), 
		.rin(rout[28]), .x(x), .y(y), .pout(pout[28]), .cout(cout[29]), 
		.rout(rout[29]), .lastbit(lastbit));

	wire pin_last = (rout[30] == 1)? xy : cout[30] ;
	bs_mult_slice I30(.clk(clk), .xy(xy), .pin(pin_last), .cin(cout[29]), 
		.rin(rout[29]), .x(x), .y(y), .pout(pout[29]), .cout(cout[30]), 
		.rout(rout[30]), .lastbit(lastbit));

endmodule
