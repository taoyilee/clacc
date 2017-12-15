/*

MIT License

Copyright (c) 2017 Michael (Tao-Yi) Lee

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

*/

module dual_clock_fifo #(
	parameter ADDR_WIDTH = 3,
	parameter DATA_WIDTH = 16
)
(
	input wire 			wr_rst_i,
	input wire 			wr_clk_i,
	input wire 			wr_en_i,
	input wire [DATA_WIDTH-1:0]	wr_data_i,

	input wire 			rd_rst_i,
	input wire 			rd_clk_i,
	input wire 			rd_en_i,
	output reg [DATA_WIDTH-1:0]	rd_data_o,

	output reg 			full_o,
	output reg 			empty_o
);

reg [ADDR_WIDTH-1:0]	wr_addr;
reg [ADDR_WIDTH-1:0]	wr_addr_gray;
reg [ADDR_WIDTH-1:0]	wr_addr_gray_rd;
reg [ADDR_WIDTH-1:0]	wr_addr_gray_rd_r;
reg [ADDR_WIDTH-1:0]	rd_addr;
reg [ADDR_WIDTH-1:0]	rd_addr_gray;
reg [ADDR_WIDTH-1:0]	rd_addr_gray_wr;
reg [ADDR_WIDTH-1:0]	rd_addr_gray_wr_r;

function [ADDR_WIDTH-1:0] gray_conv;
input [ADDR_WIDTH-1:0] in;
begin
	gray_conv = {in[ADDR_WIDTH-1],
		     in[ADDR_WIDTH-2:0] ^ in[ADDR_WIDTH-1:1]};
end
endfunction

always @(posedge wr_clk_i) begin
	if (wr_rst_i) begin
		wr_addr <= 0;
		wr_addr_gray <= 0;
	end else if (wr_en_i) begin
		wr_addr <= wr_addr + 1'b1;
		wr_addr_gray <= gray_conv(wr_addr + 1'b1);
	end
end

// synchronize read address to write clock domain
always @(posedge wr_clk_i) begin
	rd_addr_gray_wr <= rd_addr_gray;
	rd_addr_gray_wr_r <= rd_addr_gray_wr;
end

always @(posedge wr_clk_i)
	if (wr_rst_i)
		full_o <= 0;
	else if (wr_en_i)
		full_o <= gray_conv(wr_addr + 2) == rd_addr_gray_wr_r;
	else
		full_o <= full_o & (gray_conv(wr_addr + 1'b1) == rd_addr_gray_wr_r);

always @(posedge rd_clk_i) begin
	if (rd_rst_i) begin
		rd_addr <= 0;
		rd_addr_gray <= 0;
	end else if (rd_en_i) begin
		rd_addr <= rd_addr + 1'b1;
		rd_addr_gray <= gray_conv(rd_addr + 1'b1);
	end
end

// synchronize write address to read clock domain
always @(posedge rd_clk_i) begin
	wr_addr_gray_rd <= wr_addr_gray;
	wr_addr_gray_rd_r <= wr_addr_gray_rd;
end

always @(posedge rd_clk_i)
	if (rd_rst_i)
		empty_o <= 1'b1;
	else if (rd_en_i)
		empty_o <= gray_conv(rd_addr + 1) == wr_addr_gray_rd_r;
	else
		empty_o <= empty_o & (gray_conv(rd_addr) == wr_addr_gray_rd_r);

// generate dual clocked memory
reg [DATA_WIDTH-1:0] mem[(1<<ADDR_WIDTH)-1:0];

always @(posedge rd_clk_i)
	if (rd_en_i)
		rd_data_o <= mem[rd_addr];

always @(posedge wr_clk_i)
	if (wr_en_i)
		mem[wr_addr] <= wr_data_i;
endmodule
