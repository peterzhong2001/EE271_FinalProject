module score_keeper(green_in, red_in, stop, incr, clk, reset);

	input logic [15:0] green_in, red_in;
	input logic clk, reset;
	output logic stop, incr;
	logic incr_buffer, stop_buffer, collision;
	
	integer i;
	
	input_processing skprocess1 (.A(incr_buffer), .out(incr), .clk);
	input_processing skprocess2 (.A(stop_buffer), .out(stop), .clk);
	
	always_ff @(negedge clk) begin
		for (i = 0; i < 16; i++) begin
			if (green_in[i] & red_in[i]) begin
				collision <= 1;
				break;
			end
			else
				collision <= 0;
		end
	end


	always_ff @(posedge clk) begin
		if (reset) begin
			incr_buffer <= 0;
			stop_buffer <= 0;
		end
		else if (collision == 1 | red_in == 0) begin
			stop_buffer <= 1;
			incr_buffer <= 0;
		end
		else if (green_in[15] == 1) begin
			stop_buffer <= 0;
			incr_buffer <= 1;
		end
		else begin
			incr_buffer <= 0;
			stop_buffer <= 0;
		end
	end
endmodule

module score_keeper_testbench();
	logic [15:0] green_in, red_in;
	logic stop, incr, reset;
	logic CLOCK_50;
	
	score_keeper dut (.green_in, .red_in, .stop, .incr, .clk(CLOCK_50), .reset);
	
	// Set up a simulated clock.
	parameter CLOCK_PERIOD = 100;
	initial begin
		CLOCK_50 <= 0;
		forever #(CLOCK_PERIOD/2) CLOCK_50 <= ~CLOCK_50; // Forever toggle the clock
	end
	
	// Test the design
	initial begin
		
		// test collision
		reset <= 1; repeat(3) @(posedge CLOCK_50);
		reset <= 0; @(posedge CLOCK_50);
		red_in <= 16'b0100000000000000; green_in <= 16'b1111111110000011; repeat(10) @(posedge CLOCK_50);
		
		// test out of bound
		reset <= 1; repeat(3) @(posedge CLOCK_50);
		reset <= 0; @(posedge CLOCK_50);
		red_in <= 16'b0000000000000000; green_in <= 16'b1111111110000011; repeat(10) @(posedge CLOCK_50);
		
		// test scoring
		reset <= 1; red_in <= 16'b0000000000000100; repeat(3) @(posedge CLOCK_50);
		reset <= 0; @(posedge CLOCK_50);
		red_in <= 16'b0000000000000100; green_in <= 16'b1111111110000011; repeat(10) @(posedge CLOCK_50);
		
		// test nothing is happening
		reset <= 1; green_in <= 16'b0000000000000000; repeat(3) @(posedge CLOCK_50);
		reset <= 0; @(posedge CLOCK_50);
		red_in <= 16'b0000000000000100; green_in <= 16'b0000000000000000; repeat(10) @(posedge CLOCK_50);
		
		// reset
		reset <= 1; repeat(10) @(posedge CLOCK_50); // reset the module
		$stop;
	end
endmodule 