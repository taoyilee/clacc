module bs_adder_tb;
	initial begin
		$fsdbDumpfile("bs_adder");
		$fsdbDumpvars;
	end	
	
	reg clk = 1'b1;
	always  #10 clk <= ~clk;
	reg x = 1'b0;
	reg y = 1'b0;
	reg rst = 1'b0;
	wire z;
	integer i;

	bs_adder I0(.clk(clk), .x(x),  .y(y),  .z(z), .rst(rst));
	
	initial begin
		i = 0;
		@(posedge clk);
		rst <= 1'b1;
		@(posedge clk);
		rst <= 1'b0;
	 	while (i < 16) 
		begin
			@(posedge clk);
			begin
				x <= $random();
				y <= $random();
				i = i + 1;
			end
		end
      $finish;
   end
endmodule
