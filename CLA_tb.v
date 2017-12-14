`define CYCLE      30
`define SDFFILE    "./CLA.sdf"	  
`define End_CYCLE  10000000

`define PAT        "./pattern.dat"    
`define EXP0        "./golden0.dat"
   
`define EXP1        "./golden1.dat"     
    
`define EXP2        "./golden2.dat"


module CLA_tb;

	parameter N_EXP   = 16384;
	parameter N_PAT   = N_EXP;

	reg   [7:0] gray_mem [0:N_PAT-1];
	reg   [7:0] exp_mem  [0:N_EXP-1];

	reg [7:0] ipf_dbg;
	reg [7:0] exp_dbg;
	wire [7:0] ipf_data;
	reg   clk = 0;
	reg   reset = 0;
	reg   [1:0] mode;
	reg   result_compare = 0;

	integer err = 0;
	integer times = 0;
	reg over = 0;
	integer exp_num = 0;
	wire [13:0] gray_addr;
	wire [13:0] ipf_addr;
	reg [7:0] gray_data;
	reg gray_ready = 0;
	integer i;

   CLA CLA( .clk(clk),
   			.reset(reset), 
   			.mode(mode), 
            .gray_addr(gray_addr), 
            .gray_req(gray_req), 
            .gray_ready(gray_ready), 
            .gray_data(gray_data), 
			.ipf_addr(ipf_addr), 
			.ipf_valid(ipf_valid), 
			.ipf_data(ipf_data), 
			.finish(finish));
			
   ipf_mem u_ipf_mem(.ipf_valid(ipf_valid), .ipf_data(ipf_data), .ipf_addr(ipf_addr), .clk(clk));

	initial	begin
		$readmemh (`PAT, gray_mem);
	end

	initial	begin
		`ifdef MODE0
			//$display("0");
			$readmemh (`EXP0, exp_mem);
		`endif

		`ifdef MODE1
			//$display("1");
			$readmemh (`EXP1, exp_mem);
		`endif

		`ifdef MODE2
			//$display("2");
			$readmemh (`EXP2, exp_mem);
		`endif
	end

	always begin #(`CYCLE/2) clk = ~clk; end

	initial begin

		`ifdef SDF
			$sdf_annotate(`SDFFILE, CLA);
			$fsdbDumpfile("CLA_syn.fsdb");
		`else
			$fsdbDumpfile("CLA.fsdb");
		`endif
		$fsdbDumpvars;

	end

	initial begin  // data input
	   @(negedge clk)  reset = 1'b1; 
	   #(`CYCLE*2);    reset = 1'b0; 
	   @(negedge clk)  gray_ready = 1'b1; 

	   mode = 2'd0;

		`ifdef MODE1
			mode = 2'd1;
		`endif

		`ifdef MODE2
			mode = 2'd2;
		`endif

	   
	    while (finish == 0) begin             
	      if( gray_req ) begin
	         gray_data = gray_mem[gray_addr];  
	      end 
	      else begin
	         gray_data = 'hz;  
	      end                    
	      @(negedge clk); 
	    end     
	    gray_ready = 0; gray_data='hz;
		@(posedge clk) result_compare = 1; 
	end

	initial begin // result compare
		$display("-----------------------------------------------------\n");
	 	$display("START!!! Simulation Start .....\n");
	 	$display("-----------------------------------------------------\n");
		#(`CYCLE*3); 
		wait( finish ) ;
		@(posedge clk); @(posedge clk);
		for (i=0; i <N_PAT ; i=i+1) begin
				//@(posedge clk);  // TRY IT ! no comment this line for debugging !!
					exp_dbg = exp_mem[i]; ipf_dbg = u_ipf_mem.ipf_M[i];
					if (exp_mem[i] == u_ipf_mem.ipf_M[i]) begin
						err = err;
					end
					else begin
						//$display("pixel %d is FAIL !!", i); 
						err = err+1;
						if (err <= 10) $display("Output pixel %d are wrong!", i);
						if (err == 11) begin $display("Find the wrong pixel reached a total of more than 10 !, Please check the code .....\n");  end
					end
					if( ((i%1000) === 0) || (i == 16383))begin  
						if ( err === 0)
	      					$display("Output pixel: 0 ~ %d are correct!\n", i);
						else
						$display("Output Pixel: 0 ~ %d are wrong ! The wrong pixel reached a total of %d or more ! \n", i, err);
						
	  				end					
					exp_num = exp_num + 1;
		end
		over = 1;
	end


	initial  begin
	 #`End_CYCLE ;
	 	$display("-----------------------------------------------------\n");
	 	$display("Error!!! Somethings' wrong with your code ...!\n");
	 	$display("-------------------------FAIL------------------------\n");
	 	$display("-----------------------------------------------------\n");
	 	$finish;
	end

	integer f;
	reg check;

	initial begin

		`ifdef MODE0
			f = $fopen("pattern0.txt","w");
		`endif

		`ifdef MODE1
			f = $fopen("pattern1.txt","w");
		`endif

		`ifdef MODE2
			f = $fopen("pattern2.txt","w");
		`endif

	      @(posedge over)      
	      if((over) && (exp_num!='d0)) begin
	         $display("-----------------------------------------------------\n");
	         if (err == 0)  begin
	            $display("Congratulations! All data have been generated successfully!\n");
	            $display("-------------------------PASS------------------------\n");

	            check = 1;
	            $fwrite(f, "%d\n", check);
	         end
	         else begin
	            $display("There are %d errors!\n", err);
	            $display("-----------------------------------------------------\n");
		    	check = 0;
	            $fwrite(f, "%d\n", check);
	         end
	      end
	      #(`CYCLE/2); $finish;
	end
   
endmodule


module ipf_mem (ipf_valid, ipf_data, ipf_addr, clk);

	input	ipf_valid;
	input	[13:0] ipf_addr;
	input	[7:0]  ipf_data;
	input	clk;

	reg [7:0] ipf_M [0:16383];
	integer i;

	initial begin
		for (i=0; i<=16383; i=i+1) ipf_M[i] = 0;
	end

	always@(negedge clk) 
		if (ipf_valid) ipf_M[ ipf_addr ] <= ipf_data;

endmodule
