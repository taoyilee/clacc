/*

MIT License

Copyright (c) 2017 Michael (Tao-Yi) Lee

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

*/

module bs_mult_slice(clk, xy, pin, cin, rin, x, y, pout, cout, rout, lastbit);
	input clk;
	input xy, pin, cin, rin, x, y, lastbit;
	output pout, cout, rout;
	wire [2:0] cout_int;
	reg cout;
	reg rout;
	wire a, b;
	reg pin_delay;
	reg x_delay;
	reg y_delay;
	reg cout1_delay;
	assign a = x_delay & y;
	assign b = x & y_delay;
	assign pout = (rin == 1'b1) ? xy : cout_int[0];
	counter_5to3 I0(.x({a, b, pin_delay, cin, cout1_delay}), .y(cout_int));	

	always @ (posedge clk)
	begin
		if(lastbit)
		begin 
			x_delay <= 1'b0;
			y_delay <= 1'b0;
			pin_delay <= 1'b0;
			cout1_delay <= 1'b0;
			cout <= 1'b0;
			rout <= 1'b0;
		end
		else
		begin
			if(rin)
			begin
				x_delay <= x;
				y_delay <= y;
			end
			pin_delay <= pin;
			cout1_delay <= cout_int[1];
			cout <= cout_int[2];
			rout <= rin;
		end


	end
endmodule
