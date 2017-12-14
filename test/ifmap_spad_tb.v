module ifmap_spad_tb;
	initial begin
		$fsdbDumpfile("ifmap_spad");
		$fsdbDumpvars;
	end	
	
	reg clk = 1'b1;
	always  #10 clk <= ~clk;
	wire [15:0] data;
	reg [15:0] data_reg;
	reg [3:0] addr = 4'b0000;
	reg we = 1'b1;
	assign data [15:0] = we ? data_reg[15:0] : 16'bz;	
	integer i;

	ifmap_spad I0(.clk  (clk), .addr(addr),  .we(we),  .data_port(data));
	
	initial begin
		we <= 1'b1; // Write data first
		addr <= 4'b0000;
		i = 0;
		data_reg <= $random();
	 	while (i < 16) 
		begin
			@(posedge clk);
			begin
				#5
				data_reg <= $random();
				addr = addr + 1;
				i = i + 1;
			end
		end
		
		addr <= 4'b0000;
		we <= 1'b0; // Read data 
		i = 0;
	 	while (i < 16) 
		begin
			@(posedge clk);
			begin
				#5
				addr = addr + 1;
				i = i + 1;
			end
		end
      $finish;
   end
endmodule
