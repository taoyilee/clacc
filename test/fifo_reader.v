/*
 *  FIFO read BFM
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
module fifo_reader
  #(
    parameter WIDTH = 0,
    parameter MAX_BLOCK_SIZE = 1024)
   (
    input 	      clk,
    input [WIDTH-1:0] din,
    output reg	      rden = 1'b0,
    input 	      empty);

   real 	       rate = 0.5;
   integer 	       seed = 0;

   time 	       timeout = 0;
   reg 		       err_timeout = 0;

   reg 		       valid = 1'b0;

   real 	       randval;
   always @(posedge clk) begin
      valid <= rden & !empty;
      randval = $dist_uniform(seed, 0, 1000) / 1000.0;
      rden <= (randval <= rate) & !empty;
   end

   task read_word;
      output [WIDTH-1:0] data_o;

      reg 		 rd;
      time 		 t0;

      begin
	 t0 = $time;
	 while(!valid & !err_timeout) begin
	    @(posedge clk);

	    if(timeout > 0)
	      err_timeout = ($time-t0) > timeout;
	 end
	 if(err_timeout) begin
	    $display("%0d : Timeout in FIFO reader", $time);
            $finish;
         end
	 data_o = din;
	 err_timeout = 1'b0;
	 @(posedge clk);
      end
   endtask

endmodule
