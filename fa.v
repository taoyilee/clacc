module fa(x, y, cin, cout, sum);
	input x, y, cin;
	output cout, sum;
	wire cout_int, cout_int2;
	wire sum_int;
	ha I0(.x(x), .y(y), .cout(cout_int), .sum(sum_int));
	ha I1(.x(sum_int), .y(cin), .cout(cout_int2), .sum(sum));
	assign cout = cout_int | cout_int2;
endmodule
