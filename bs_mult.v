module bs_mult_slice(clk, xy, x, y, pin, cin, rin, lastbit, pout, cout, rout);
	input clk;
	input xy, x, y, pin, cin, rin, lastbit;
	output pout;
	output reg cout, rout;
	wire a, b;
	assign a = x_delay & y;
	assign b = x & y_delay;
	assign pout = (rin == 1) ? xy : cout[0];

	reg x_delay;
	reg y_delay;
	reg pin_delay;
	reg cout1_delay;
	wire [2:0] cout;
	counter_5to3 I0(.x({a, b, pin_delay, cin, cout1_delay}), .y(cout));	

	always @ (posedge clk)
	begin
		if(lastbit)
		begin 
			x_delay <= 1'b0;
			y_delay <= 1'b0;
			pin_delay <= 1'b0;
			cout1_delay <= 1'b0;
			cout <= 1'b0;
			rout <= 1'b0;
		end

		if(rin)
		begin
			x_delay <= x;
			y_delay <= y;
		end

		pin_delay <= pin;
		cout1_delay <= cout[1];
		cout <= cout[2];
		rout <= rin;
	end
endmodule
