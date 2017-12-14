/*
 *  FIFO stimuli generator/checker
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
module fifo_tester
  #(parameter DEPTH = 0,
    parameter DW    = 0)
   (input wire 		 rst_i,
    input wire 		 wr_clk_i,
    output wire 	 wr_en_o,
    output wire [DW-1:0] wr_data_o,
    input wire 		 full_i,

    input wire 		 rd_clk_i,
    output wire 	 rd_en_o,
    input wire [DW-1:0]  rd_data_i,
    input wire 		 empty_i);

   function [DW-1:0] randvec;
      input integer seed;

      integer idx;
      for (idx = DW ; idx>0 ; idx=idx-32)
	//randvec = (randvec << 32)| $random(seed);
	randvec = (randvec << 32)| $random();
   endfunction

   reg [DW-1:0] mem [0:DEPTH-1];

   integer 	seed = 10;

   fifo_writer
     #(.WIDTH (DW))
   writer
     (.clk (wr_clk_i),
      .dout (wr_data_o),
      .wren (wr_en_o),
      .full (full_i));

   fifo_reader
     #(.WIDTH (DW))
   reader
     (.clk (rd_clk_i),
      .din  (rd_data_i),
      .rden (rd_en_o),
      .empty (empty_i));

   task fifo_write;
      input integer transactions_i;
      input real    write_rate;

      integer 	    index;
      integer 	    tmp;
      reg [DW-1:0]  data;
      integer 	    dw_idx;

      begin
	 //Cap rate to [0.0-1.0]
	 if(write_rate > 1.0) write_rate = 1.0;
	 if(write_rate < 0.0) write_rate = 0.0;
	 writer.rate = write_rate;

	 index = 0;

	 @(posedge wr_clk_i);
	 while(index < transactions_i) begin

	    data = randvec(seed);

	    mem[index % DEPTH] = data;
	    writer.write_word(data);

	    index = index + 1;
	 end
      end
   endtask

   task fifo_verify;
      input integer transactions_i;
      input real    read_rate;
      output integer errors;

      integer 	    index ;
      reg [DW-1:0]  received;
      reg [DW-1:0]  expected;

      begin
	 errors = 0;

	 //Cap rate to [0.0-1.0]
	 if(read_rate > 1.0) read_rate = 1.0;
	 if(read_rate < 0.0) read_rate = 0.0;
	 reader.rate = read_rate;
	 index = 0;
	 @(posedge rd_clk_i);
	 while (index < transactions_i) begin

	    reader.read_word(received);

	    expected = mem[index % DEPTH];
	    if(expected !==
	       received) begin
	       $display("Error at index %0d. Expected 0x%4x, got 0x%4x", index, expected, received);
	       errors = errors + 1;
	    end
	    index = index + 1;
	 end
      end
   endtask

endmodule
