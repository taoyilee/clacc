/*
 *  Dual clock FIFO testbench
 *
 *  Copyright (C) 2017  Olof Kindgren <olof.kindgren@gmail.com>
 *
 *  Permission to use, copy, modify, and/or distribute this software for any
 *  purpose with or without fee is hereby granted, provided that the above
 *  copyright notice and this permission notice appear in all copies.
 *
 *  THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
 *  WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
 *  MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
 *  ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
 *  WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
 *  ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
 *  OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
 */
module mult_pipe2_tb
  #(parameter SIZE  = 16);

	parameter CYCLES = 15;
	integer index = 0;
	initial begin
		$fsdbDumpfile("mult_pipe2");
		$fsdbDumpvars;
	end	

   reg clk = 1'b1;

   always  #2 clk <= ~clk;

	reg [SIZE-1:0] a;
	reg [SIZE-1:0] b;
	wire [2*SIZE-1:0] pdt;

   mult_pipe2 #(.SIZE (SIZE), .LVL (2))
   dut (  .clk  (clk), .a(a),  .b(b),  .pdt(pdt));

   initial begin
	 	while (index < CYCLES) 
		begin
			@(negedge clk);
			begin
				a <= $random();
				b <= $random();
			end
			index = index + 1;
		end
      $finish;
   end

endmodule
