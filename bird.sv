module bird (lights, push, fall, clk, reset);

	input logic push, fall, clk, reset;
	output logic [15:0] lights;
	
	// connecting all the light modules together
	bird_light bl0 (.in(push), .fall, .uplit(1'b0), .downlit(lights[1]), .out(lights[0]), .clk, .reset);
	bird_light bl1 (.in(push), .fall, .uplit(lights[0]), .downlit(lights[2]), .out(lights[1]), .clk, .reset);
	bird_light bl2 (.in(push), .fall, .uplit(lights[1]), .downlit(lights[3]), .out(lights[2]), .clk, .reset);
	bird_light bl3 (.in(push), .fall, .uplit(lights[2]), .downlit(lights[4]), .out(lights[3]), .clk, .reset);
	
	bird_light bl4 (.in(push), .fall, .uplit(lights[3]), .downlit(lights[5]), .out(lights[4]), .clk, .reset);
	bird_light bl5 (.in(push), .fall, .uplit(lights[4]), .downlit(lights[6]), .out(lights[5]), .clk, .reset);
	bird_light bl6 (.in(push), .fall, .uplit(lights[5]), .downlit(lights[7]), .out(lights[6]), .clk, .reset);
	bird_light bl7 (.in(push), .fall, .uplit(lights[6]), .downlit(lights[8]), .out(lights[7]), .clk, .reset);
	
	bird_light bl8 (.in(push), .fall, .uplit(lights[7]), .downlit(lights[9]), .out(lights[8]), .clk, .reset);
	bird_light bl9 (.in(push), .fall, .uplit(lights[8]), .downlit(lights[10]), .out(lights[9]), .clk, .reset);
	bird_light_center blA (.in(push), .fall, .uplit(lights[9]), .downlit(lights[11]), .out(lights[10]), .clk, .reset);
	bird_light blB (.in(push), .fall, .uplit(lights[10]), .downlit(lights[12]), .out(lights[11]), .clk, .reset);
	
	bird_light blC (.in(push), .fall, .uplit(lights[11]), .downlit(lights[13]), .out(lights[12]), .clk, .reset);
	bird_light blD (.in(push), .fall, .uplit(lights[12]), .downlit(lights[14]), .out(lights[13]), .clk, .reset);
	bird_light blE (.in(push), .fall, .uplit(lights[13]), .downlit(lights[15]), .out(lights[14]), .clk, .reset);
	bird_light blF (.in(push), .fall, .uplit(lights[14]), .downlit(1'b0), .out(lights[15]), .clk, .reset);

	
endmodule 



module bird_testbench();
	logic push, fall, reset;
	logic [15:0] lights;
	logic CLOCK_50;
	
	bird dut (.lights, .push, .fall, .clk(CLOCK_50), .reset);
	
	parameter CLOCK_PERIOD = 100;
	initial begin
		CLOCK_50 <= 0;
		forever #(CLOCK_PERIOD/2) CLOCK_50 <= ~CLOCK_50; // Forever toggle the clock
	end
	
	initial begin
		// reset the module
		reset <= 1; repeat(5) @(posedge CLOCK_50);
		reset <= 0; fall <= 0; push <= 0; @(posedge CLOCK_50);
		
		fall <= 1; @(posedge CLOCK_50);
		fall <= 0; @(posedge CLOCK_50);
		fall <= 1; @(posedge CLOCK_50);
		fall <= 0; @(posedge CLOCK_50);
		fall <= 1; @(posedge CLOCK_50);
		fall <= 0; @(posedge CLOCK_50);
		
		push <= 1; @(posedge CLOCK_50);
		push <= 0; @(posedge CLOCK_50);
		push <= 1; @(posedge CLOCK_50);
		push <= 0; @(posedge CLOCK_50);
		push <= 1; @(posedge CLOCK_50);
		push <= 0; @(posedge CLOCK_50);
		
		$stop;
	end
endmodule 