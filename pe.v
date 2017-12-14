module pe(clk_noc, clk_pe, ifmap, filt, input_psum, output_psum)
	input clk_noc;
	input clk_pe;
	input ifmap;
	input filt;
	input input_psum;
	output out_psum;
	
	I0 ifmap_spad(ifmap);
	I1 filt_spad(filt);
	I2 psum_spad(psum);

endmodule
