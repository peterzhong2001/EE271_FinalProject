module LFSR (clk, out, reset);
	input logic clk, reset;
	output logic [9:0] out;
	logic xnor_out;
	
	xnor xn1 (xnor_out, out[3], out[0]);
	D_FF_R dff1 (.d(xnor_out), .q(out[9]), .clk, .reset);
	D_FF_R dff2 (.d(out[9]), .q(out[8]), .clk, .reset);
	D_FF_R dff3 (.d(out[8]), .q(out[7]), .clk, .reset);
	D_FF_R dff4 (.d(out[7]), .q(out[6]), .clk, .reset);
	D_FF_R dff5 (.d(out[6]), .q(out[5]), .clk, .reset);
	D_FF_R dff6 (.d(out[5]), .q(out[4]), .clk, .reset);
	D_FF_R dff7 (.d(out[4]), .q(out[3]), .clk, .reset);
	D_FF_R dff8 (.d(out[3]), .q(out[2]), .clk, .reset);
	D_FF_R dff9 (.d(out[2]), .q(out[1]), .clk, .reset);
	D_FF_R dff10 (.d(out[1]), .q(out[0]), .clk, .reset);
endmodule 

module LFSR_testbench();
	logic CLOCK_50;
	logic [9:0] out;
	logic reset;

	LFSR dut (.clk(CLOCK_50), .out, .reset);
	
	// Set up a simulated clock.
	parameter CLOCK_PERIOD = 100;
	initial begin
		CLOCK_50 <= 0;
		forever #(CLOCK_PERIOD/2) CLOCK_50 <= ~CLOCK_50; // Forever toggle the clock
	end
	
	// Test the design
	initial begin
		reset <= 1; @(posedge CLOCK_50);
		reset <= 0; @(posedge CLOCK_50);
		repeat(30) @(posedge CLOCK_50);
		$stop; // end the simulation
	end
endmodule 