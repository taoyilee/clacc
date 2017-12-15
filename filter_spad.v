/*

MIT License

Copyright (c) 2017 Michael (Tao-Yi) Lee

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

*/


module filter_spad(clk, addr, we, data_port);
	// 224 * 16bit
	input clk;
	input [7:0] addr;
	input we; // write enable signal, 0: Read; 1: Write
	inout [15:0] data_port;
	reg [15:0] data_out;
	reg [15:0] mem [223:0]; // 12 * 16bit

	assign data_port = !we ? data_out : 16'bz;

	always @ (posedge clk)	
	begin
		if (we)
			mem[addr] <= data_port;
		else
		begin
			data_out <= mem[addr];
		end

	end
endmodule
