module bs_adder(x, y, clk, z, rst);
	input x, y, clk, rst;
	output reg z;
	reg cin_int;	
	wire sum_int;
	
	fa I0(.x(x), .y(y), .cin(cin_int), .cout(cout_int), .sum(sum_int));
	always @ (posedge clk)	
	begin
		if(rst)
		begin
			cin_int <= 1'b0;
			z <= 1'b0;
		end
		else
		begin
			cin_int <= cout_int;
			z <= sum_int;
		end
	end
endmodule
