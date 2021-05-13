module pillar (pattern_in, out, clk, reset);

	input logic [15:0] pattern_in;
	input logic clk, reset;
	output logic [15:0][15:0] out;
	
	logic [15:0] po15, po14, po13, po12, po11, po10, po9, po8, po7, po6, po5, po4, po3, po2, po1, po0;
	logic [15:0] lit;
	logic pulse;
	integer count;
	
	assign out[15] = po15;
	assign out[14] = po14;
	assign out[13] = po13;
	assign out[12] = po12;
	assign out[11] = po11;
	assign out[10] = po10;
	assign out[9] = po9;
	assign out[8] = po8;
	assign out[7] = po7;
	assign out[6] = po6;
	assign out[5] = po5;
	assign out[4] = po4;
	assign out[3] = po3;
	assign out[2] = po2;
	assign out[1] = po1;
	assign out[0] = po0;
	
	column_driver cd15 (.pattern_in, .pattern_out(po15), .right_lit(pulse), .lit(lit[15]), .clk, .reset);
	column_driver cd14 (.pattern_in(po15), .pattern_out(po14), .right_lit(lit[15]), .lit(lit[14]), .clk, .reset);
	column_driver cd13 (.pattern_in(po14), .pattern_out(po13), .right_lit(lit[14]), .lit(lit[13]), .clk, .reset);
	column_driver cd12 (.pattern_in(po13), .pattern_out(po12), .right_lit(lit[13]), .lit(lit[12]), .clk, .reset);
	column_driver cd11 (.pattern_in(po12), .pattern_out(po11), .right_lit(lit[12]), .lit(lit[11]), .clk, .reset);
	column_driver cd10 (.pattern_in(po11), .pattern_out(po10), .right_lit(lit[11]), .lit(lit[10]), .clk, .reset);
	column_driver cd9 (.pattern_in(po10), .pattern_out(po9), .right_lit(lit[10]), .lit(lit[9]), .clk, .reset);
	column_driver cd8 (.pattern_in(po9), .pattern_out(po8), .right_lit(lit[9]), .lit(lit[8]), .clk, .reset);
	column_driver cd7 (.pattern_in(po8), .pattern_out(po7), .right_lit(lit[8]), .lit(lit[7]), .clk, .reset);
	column_driver cd6 (.pattern_in(po7), .pattern_out(po6), .right_lit(lit[7]), .lit(lit[6]), .clk, .reset);
	column_driver cd5 (.pattern_in(po6), .pattern_out(po5), .right_lit(lit[6]), .lit(lit[5]), .clk, .reset);
	column_driver cd4 (.pattern_in(po5), .pattern_out(po4), .right_lit(lit[5]), .lit(lit[4]), .clk, .reset);
	column_driver cd3 (.pattern_in(po4), .pattern_out(po3), .right_lit(lit[4]), .lit(lit[3]), .clk, .reset);
	column_driver cd2 (.pattern_in(po3), .pattern_out(po2), .right_lit(lit[3]), .lit(lit[2]), .clk, .reset);
	column_driver cd1 (.pattern_in(po2), .pattern_out(po1), .right_lit(lit[2]), .lit(lit[1]), .clk, .reset);
	column_driver cd0 (.pattern_in(po1), .pattern_out(po0), .right_lit(lit[1]), .lit(lit[0]), .clk, .reset);
	
	always_ff @(posedge clk) begin
		if (reset)
			count <= 3;
		else if (count == 0) begin
			count <= 3;
			pulse <= 1'b1;
		end
		else begin
			count <= count - 1;
			pulse <= 1'b0;
		end
	end
	
endmodule 



module pillar_testbench();
	logic [15:0] pattern_in;
	logic clk, reset;
	logic [15:0][15:0] out;

	pillar dut (.pattern_in, .out, .clk, .reset);
	
	// Set up a simulated clock.
	parameter CLOCK_PERIOD = 100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk; // Forever toggle the clock
	end
	
	// Test the design
	initial begin
		reset <= 1; repeat(5) @(posedge clk);
		reset <= 0; pattern_in <= 0; repeat(5) @(posedge clk);
		pattern_in <= 16'b1110000011111111; repeat(10) @(posedge clk);
		reset <= 1; repeat(5) @(posedge clk);
		$stop; // End the simulation.
	end
endmodule 