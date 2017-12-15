module pe(clk_noc, clk_pe, ifmap, filt, input_psum, output_psum)
	input clk_noc;
	input clk_pe;
	input ifmap;
	input filt;
	input input_psum;
	output out_psum;
	reg [1:0] state;

	parameter IDLE=2'b00, DATA=2'b01, MULT=2'b10, ACCU=2'b11;
	
	I0 dual_clock_fifo(
		.wr_rst_i(wr_rst_i), 
		.wr_clk_i(clk_noc),
		.wr_en_i(wr_en_i),
		.wr_data_i(),
		.rd_rst_i(),
		.rd_clk_i(clk_pe),
		.rd_en_i(),
		.rd_data_o(),
		.full_o(),
		.empty_o(),
	);
	I1 ifmap_spad(.clk(clk_pe), .addr(), .we(), .data_port());

	/* psum */
	I2 dual_clock_fifo(
		.wr_rst_i(wr_rst_i), 
		.wr_clk_i(clk_noc),
		.wr_en_i(wr_en_i),
		.wr_data_i(),
		.rd_rst_i(),
		.rd_clk_i(clk_pe),
		.rd_en_i(),
		.rd_data_o(),
		.full_o(),
		.empty_o(),
	);
	I3 psum_spad(.clk(clk_pe), .addr(), .we(), .data_port());

	/* filter kernel IO */
	I4 dual_clock_fifo(
		.wr_rst_i(wr_rst_i), 
		.wr_clk_i(clk_noc),
		.wr_en_i(wr_en_i),
		.wr_data_i(),
		.rd_rst_i(),
		.rd_clk_i(),
		.rd_en_i(),
		.rd_data_o(),
		.full_o(),
		.empty_o(),
	);
	I5 filt_spad(.clk(clk_pe), .addr(), .we(), .data_port());

endmodule
