module bs_mult(clk, x, y, p, firstbit, lastbit);
	input clk;
	input x, y, firstbit, lastbit;
	output p;
	assign xy = x & y;

	wire [13:0] pout;
	wire [14:0] rout;
	wire [14:0] cout;

	bs_mult_slice I0(.clk(clk), .xy(xy), .pin(pout[0]), .cin(1'b0), 
		.rin(firstbit), .x(x), .y(y), .pout(p), .cout(cout[0]), 
		.rout(rout[0]), .lastbit(lastbit));

	bs_mult_slice I1(.clk(clk), .xy(xy), .pin(pout[1]), .cin(cout[0]), 
		.rin(rout[0]), .x(x), .y(y), .pout(pout[0]), .cout(cout[1]), 
		.rout(rout[1]), .lastbit(lastbit));

	bs_mult_slice I2(.clk(clk), .xy(xy), .pin(pout[2]), .cin(cout[1]), 
		.rin(rout[1]), .x(x), .y(y), .pout(pout[1]), .cout(cout[2]), 
		.rout(rout[2]), .lastbit(lastbit));

	bs_mult_slice I3(.clk(clk), .xy(xy), .pin(pout[3]), .cin(cout[2]), 
		.rin(rout[2]), .x(x), .y(y), .pout(pout[2]), .cout(cout[3]), 
		.rout(rout[3]), .lastbit(lastbit));

	bs_mult_slice I4(.clk(clk), .xy(xy), .pin(pout[4]), .cin(cout[3]), 
		.rin(rout[4]), .x(x), .y(y), .pout(pout[3]), .cout(cout[4]), 
		.rout(rout[4]), .lastbit(lastbit));

	bs_mult_slice I5(.clk(clk), .xy(xy), .pin(pout[5]), .cin(cout[4]), 
		.rin(rout[5]), .x(x), .y(y), .pout(pout[4]), .cout(cout[5]), 
		.rout(rout[5]), .lastbit(lastbit));

	bs_mult_slice I6(.clk(clk), .xy(xy), .pin(pout[6]), .cin(cout[5]), 
		.rin(rout[6]), .x(x), .y(y), .pout(pout[5]), .cout(cout[6]), 
		.rout(rout[6]), .lastbit(lastbit));

	bs_mult_slice I7(.clk(clk), .xy(xy), .pin(pout[7]), .cin(cout[6]), 
		.rin(rout[7]), .x(x), .y(y), .pout(pout[6]), .cout(cout[7]), 
		.rout(rout[7]), .lastbit(lastbit));

	bs_mult_slice I8(.clk(clk), .xy(xy), .pin(pout[8]), .cin(cout[7]), 
		.rin(rout[8]), .x(x), .y(y), .pout(pout[7]), .cout(cout[8]), 
		.rout(rout[8]), .lastbit(lastbit));

	bs_mult_slice I9(.clk(clk), .xy(xy), .pin(pout[9]), .cin(cout[8]), 
		.rin(rout[9]), .x(x), .y(y), .pout(pout[8]), .cout(cout[9]), 
		.rout(rout[9]), .lastbit(lastbit));

	bs_mult_slice I10(.clk(clk), .xy(xy), .pin(pout[10]), .cin(cout[9]), 
		.rin(rout[10]), .x(x), .y(y), .pout(pout[9]), .cout(cout[10]), 
		.rout(rout[10]), .lastbit(lastbit));

	bs_mult_slice I11(.clk(clk), .xy(xy), .pin(pout[11]), .cin(cout[10]), 
		.rin(rout[11]), .x(x), .y(y), .pout(pout[10]), .cout(cout[11]), 
		.rout(rout[11]), .lastbit(lastbit));

	bs_mult_slice I12(.clk(clk), .xy(xy), .pin(pout[12]), .cin(cout[11]), 
		.rin(rout[12]), .x(x), .y(y), .pout(pout[11]), .cout(cout[12]), 
		.rout(rout[12]), .lastbit(lastbit));

	bs_mult_slice I13(.clk(clk), .xy(xy), .pin(pout[13]), .cin(cout[12]), 
		.rin(rout[13]), .x(x), .y(y), .pout(pout[12]), .cout(cout[13]), 
		.rout(rout[13]), .lastbit(lastbit));

	wire pin_last = (rout[14] == 1)? xy : cout[14] ;
	bs_mult_slice I14(.clk(clk), .xy(xy), .pin(pin_last), .cin(cout[13]), 
		.rin(rout[13]), .x(x), .y(y), .pout(pout[13]), .cout(cout[14]), 
		.rout(rout[14]), .lastbit(lastbit));

endmodule
