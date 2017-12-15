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
		x <= 1'b1; y <= 1'b1;
		// bit 1
		@(posedge clk);
		i <= 1;
		x <= 1'b1; y <= 1'b0;
		fb <= 1'b0;
		// bit 2
		@(posedge clk);
		i <= 2;
		x <= 1'b1; y <= 1'b1;
		// bit 3
		@(posedge clk);
		i <= 3;
		x <= 1'b1; y <= 1'b1;
		// bit 4
		@(posedge clk);
		i <= 4;
		x <= 1'b1; y <= 1'b1;
		// bit 5
		@(posedge clk);
		i <= 5;
		x <= 1'b1; y <= 1'b1;
		// bit 6
		@(posedge clk);
		i <= 6;
		x <= 1'b1; y <= 1'b1;
		// bit 7
		@(posedge clk);
		i <= 7;
		x <= 1'b1; y <= 1'b1;
		// bit 8
		@(posedge clk);
		i <= 8;
		x <= 1'b1; y <= 1'b1;
		// bit 9
		@(posedge clk);
		i <= 9;
		x <= 1'b1; y <= 1'b1;
		// bit 10
		@(posedge clk);
		i <= 10;
		x <= 1'b1; y <= 1'b1;
		// bit 11
		@(posedge clk);
		i <= 11;
		x <= 1'b1; y <= 1'b1;
		// bit 12
		@(posedge clk);
		i <= 12;
		x <= 1'b1; y <= 1'b1;
		// bit 13
		@(posedge clk);
		i <= 13;
		x <= 1'b1; y <= 1'b1;
		// bit 14
		@(posedge clk);
		i <= 14;
		x <= 1'b1; y <= 1'b1;
		// bit 15
		@(posedge clk);
		i <= 15;
		x <= 1'b1; y <= 1'b1;
		// bit 16
		@(posedge clk);
		i <= 16;
		x <= 1'b1; y <= 1'b1;
		// bit 15
		@(posedge clk);
		i <= 17;
		x <= 1'b1; y <= 1'b1;
		// bit 15
		@(posedge clk);
		i <= 18;
		x <= 1'b1; y <= 1'b1;
		// bit 15
		@(posedge clk);
		i <= 19;
		x <= 1'b1; y <= 1'b1;
		// bit 15
		@(posedge clk);
		i <= 20;
		x <= 1'b1; y <= 1'b1;
		// bit 15
		@(posedge clk);
		i <= 21;
		x <= 1'b1; y <= 1'b1;
		// bit 22
		@(posedge clk);
		i <= 22;
		x <= 1'b1; y <= 1'b1;
		// bit 15
		@(posedge clk);
		i <= 23;
		x <= 1'b1; y <= 1'b1;
		// bit 15
		@(posedge clk);
		i <= 24;
		x <= 1'b1; y <= 1'b1;
		// bit 15
		@(posedge clk);
		i <= 25;
		x <= 1'b1; y <= 1'b1;
		// bit 15
		@(posedge clk);
		i <= 26;
		x <= 1'b1; y <= 1'b1;
		// bit 15
		@(posedge clk);
		i <= 27;
		x <= 1'b1; y <= 1'b1;
		// bit 15
		@(posedge clk);
		i <= 28;
		x <= 1'b1; y <= 1'b1;
		// bit 15
		@(posedge clk);
		i <= 29;
		x <= 1'b1; y <= 1'b1;
		// bit 15
		@(posedge clk);
		i <= 30;
		x <= 1'b1; y <= 1'b1;
		// bit 15
		@(posedge clk);
		i <= 31;
		x <= 1'b1; y <= 1'b1;
		lb <= 1'b1;		
		// ends here
		@(posedge clk);
		i <= 0;
		x <= 1'b0; y <= 1'b0;
		lb <= 1'b0;		
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
      $finish;
   end
endmodule
