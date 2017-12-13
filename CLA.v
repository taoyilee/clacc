module IPF (clk, reset, mode, gray_addr, gray_req, gray_ready, gray_data, ipf_addr, ipf_valid, ipf_data, finish);

	parameter addrWidth = 14;
	parameter dataWidth = 8;

	input clk, reset, gray_ready;
	input [1:0] mode;
	input [dataWidth-1:0] gray_data;
    
	output [addrWidth-1:0] gray_addr, ipf_addr;
	output gray_req, ipf_valid, finish;
	output [dataWidth-1:0] ipf_data;
	/*
    reg [dataWidth-1:0] W0, next_W0, W1, next_W1, W2, next_W2,
	                    W3, next_W3, W4, next_W4, W5, next_W5,
						W6, next_W6, W7, next_W7, W8, next_W8;
					*/	
	reg [dataWidth-1:0] window[0:8];
	reg [dataWidth-1:0] next_window[0:8];
	
	
	reg[2:0] now_state, next_state;
	reg[3:0] cnt, next_cnt;
	
	reg[addrWidth-1:0] gray_addr, next_gray_addr;
	reg[addrWidth-1:0] ipf_addr, next_ipf_addr;
	
	
	parameter IDLE = 2'b00;
	parameter READ = 2'b01;
	parameter WRITE = 2'b10;
	parameter SLIDE = 2'b11;
	parameter MAX_IPF_ADDR = 14'd16254;
	
	assign ipf_valid = (now_state == WRITE) ? 1'b1 : 1'b0;
	assign finish = (now_state == IDLE && ipf_addr >= MAX_IPF_ADDR) ? 1'b1 : 1'b0;
	assign gray_req = (now_state == IDLE && ipf_addr >= MAX_IPF_ADDR) ? 1'b0 : 1'b1;
    wire [dataWidth-1:0] ipf_data1, ipf_data2, ipf_data3;

	assign ipf_data1[0] = window[0] >= window[4] ? 1'b1 : 1'b0;
	assign ipf_data1[1] = window[1] >= window[4] ? 1'b1 : 1'b0;
	assign ipf_data1[2] = window[2] >= window[4] ? 1'b1 : 1'b0;
	assign ipf_data1[3] = window[3] >= window[4] ? 1'b1 : 1'b0;
	assign ipf_data1[4] = window[5] >= window[4] ? 1'b1 : 1'b0;
	assign ipf_data1[5] = window[6] >= window[4] ? 1'b1 : 1'b0;
	assign ipf_data1[6] = window[7] >= window[4] ? 1'b1 : 1'b0;
	assign ipf_data1[7] = window[8] >= window[4] ? 1'b1 : 1'b0;
	
	assign ipf_data2 =  (window[4] >> 8'd1) - (window[8] >> 8'd1);
	assign ipf_data3 = window[4] - (window[0]>>8'd3) - (window[1]>>8'd3) - (window[2]>>8'd3)
	                   - (window[3]>>8'd3) - (window[5]>>8'd3) - (window[6]>>8'd3)
					   - (window[7]>>8'd3) - (window[8]>>8'd3);
	assign ipf_data = (mode == 2'b00) ? ipf_data1 : (mode == 2'b01) ? ipf_data2 : ipf_data3;
	
	
	always @(posedge clk or posedge reset)
	begin
	    if(reset)
		begin
		  now_state <= IDLE;
		  window[0] = 8'd0;
		  window[1] = 8'd0;
		  window[2] = 8'd0;
		  window[3] = 8'd0;
		  window[4] = 8'd0;
		  window[5] = 8'd0;
		  window[6] = 8'd0;
		  window[7] = 8'd0;	  
		  window[8] = 8'd0;
		  gray_addr <= 14'd0;
		  ipf_addr <= 14'd129;
		  cnt <= 4'd0;
		end
		else
		begin
		  now_state <= next_state;
		  window[0] = next_window[0];
		  window[1] = next_window[1];
		  window[2] = next_window[2];
		  window[3] = next_window[3];
		  window[4] = next_window[4];
		  window[5] = next_window[5];
		  window[6] = next_window[6];
		  window[7] = next_window[7];
		  window[8] = next_window[8];
		  gray_addr <= next_gray_addr;
		  ipf_addr <= next_ipf_addr;
		  cnt <= next_cnt;
		end
	end
	always @(*)
	begin
	      next_state = now_state;
		  next_window[0] = window[0];
		  next_window[1] = window[1];
		  next_window[2] = window[2];
		  next_window[3] = window[3];
		  next_window[4] = window[4];
		  next_window[5] = window[5];
		  next_window[6] = window[6];
		  next_window[7] = window[7];
		  next_window[8] = window[8];
		  next_gray_addr = gray_addr;
		  next_ipf_addr = ipf_addr;
		  next_cnt = cnt;
		  case(now_state)
		     IDLE:
			 begin
			    if(gray_ready)
				begin
			     next_state = READ;
				 next_cnt = 4'd0;
				end
			 end
			 READ:
			 begin
			    //$display("w0 = %d w1 = %d w2 = %d w3 = %d w4 = %d", window[0], window[1], window[2], window[3], window[4]);
			    next_window[cnt] = gray_data;
				if(cnt == 4'd8)
				begin
				  next_gray_addr = gray_addr - 14'd255;
				  next_state = WRITE;
				  next_cnt = 4'd0;
				end
			    else if(cnt % 4'd3 == 4'd2) 
				begin
				  next_gray_addr = gray_addr + 14'd126;
				  next_cnt = cnt + 4'd1;
				end
				else 
				begin
				  next_gray_addr = gray_addr + 14'd1;
				  next_cnt = cnt + 4'd1;
				end
			 end
			 SLIDE:
			 begin
			    next_gray_addr = gray_addr + 14'd128;
			    if(cnt == 4'd0)
				begin
				  next_window[5] = gray_data;
				  next_cnt = cnt + 4'd1;
				end
				else
				begin
				  next_window[8] = gray_data;
				  next_state = WRITE;
				  next_gray_addr = gray_addr - 14'd255;
				end	
			 end
			 WRITE:
			 begin
			    if(ipf_addr == MAX_IPF_ADDR) 
				begin
				   next_state = IDLE;
				end
				else if(ipf_addr % 14'd128 == 14'd126) 
				begin
				   next_ipf_addr = ipf_addr + 14'd3;
				   next_state = READ;
				   next_gray_addr = gray_addr;
				end
				else 
				begin
				   next_state = SLIDE;
				   next_ipf_addr = ipf_addr + 14'd1;
				   next_gray_addr = gray_addr + 14'd128;
				end
			    next_cnt = 4'd0;
				next_window[0] = window[1];
				next_window[1] = window[2];
				next_window[2] = gray_data;
				next_window[3] = window[4];
				next_window[4] = window[5];
				next_window[6] = window[7];
				next_window[7] = window[8];
			 end
		  endcase
	end

endmodule
