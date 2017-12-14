module ifmap_spad(clk, addr, we, data_port);
	// 12 * 16bit
	input clk;
	input [3:0] addr;
	input we; // write enable signal, 0: Read; 1: Write
	inout [15:0] data_port;
	reg [15:0] data_out;
	reg [15:0] mem [11:0]; // 12 * 16bit

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
