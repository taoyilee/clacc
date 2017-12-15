module ha(x, y, cout, sum);
	input x, y;
	output cout, sum;

	assign sum = x ^ y;
	assign cout = x & y;

endmodule
