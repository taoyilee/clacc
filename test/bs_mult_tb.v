module bs_mult_tb;
	initial begin
		$fsdbDumpfile("bs_mult");
		$fsdbDumpvars;
	end	
	
	reg clk = 1'b1;
	always  #10 clk <= ~clk;
	reg x = 1'b0;
	reg y = 1'b0;
	reg fb = 1'b0;
	reg lb = 1'b0;
	wire p;
	integer i = -1;
	bs_mult I0(.clk(clk), .x(x),  .y(y),  .p(p), .firstbit(fb), .lastbit(lb));
	
	initial begin
		@(posedge clk);
		lb <= 1'b1;
		// bit 0
		@(posedge clk);
		i <= 0;
		lb <= 1'b0;	fb <= 1'b1;		
		x <= 1'b0; y <= 1'b1;
		// bit 1
		@(posedge clk);
		i <= 1;
		x <= 1'b1; y <= 1'b1;
		fb <= 1'b0;
		// bit 2
		@(posedge clk);
		i <= 2;
		x <= 1'b1; y <= 1'b0;
		// bit 3
		@(posedge clk);
		i <= 3;
		x <= 1'b1; y <= 1'b0;
		// bit 4
		@(posedge clk);
		i <= 4;
		x <= 1'b1; y <= 1'b0;
		// bit 5
		@(posedge clk);
		i <= 5;
		x <= 1'b1; y <= 1'b0;
		// bit 6
		@(posedge clk);
		i <= 6;
		x <= 1'b1; y <= 1'b0;
		// bit 7
		@(posedge clk);
		i <= 7;
		x <= 1'b1; y <= 1'b0;
		// bit 8
		@(posedge clk);
		i <= 8;
		x <= 1'b1; y <= 1'b0;
		// bit 9
		@(posedge clk);
		i <= 9;
		x <= 1'b1; y <= 1'b0;
		// bit 10
		@(posedge clk);
		i <= 10;
		x <= 1'b1; y <= 1'b0;
		// bit 11
		@(posedge clk);
		i <= 11;
		x <= 1'b1; y <= 1'b0;
		// bit 12
		@(posedge clk);
		i <= 12;
		x <= 1'b1; y <= 1'b0;
		// bit 13
		@(posedge clk);
		i <= 13;
		x <= 1'b1; y <= 1'b0;
		// bit 14
		@(posedge clk);
		i <= 14;
		x <= 1'b1; y <= 1'b0;
		// bit 15
		@(posedge clk);
		i <= 15;
		x <= 1'b1; y <= 1'b0;
		lb <= 1'b1;		
		@(posedge clk);
		x <= 1'b1; y <= 1'b0;
		lb <= 1'b0;		
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
      $finish;
   end
endmodule
