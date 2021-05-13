// Top-level module that defines the I/Os for the DE-1 SoC board
module DE1_SoC (HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, SW, LEDR, GPIO_1, CLOCK_50);
    output logic [6:0]  HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	 output logic [9:0]  LEDR;
    input  logic [3:0]  KEY;
    input  logic [9:0]  SW;
    output logic [35:0] GPIO_1;
    input logic CLOCK_50;

	 // Turn off HEX displays
    assign HEX3 = '1;
    assign HEX4 = '1;
	 
	 
	 /* Set up system base clock to 1526 Hz (50 MHz / 2**(14+1))
	    ===========================================================*/
	 logic [31:0] clk;
	 logic SYSTEM_CLOCK;
	 
	 clock_divider divider (.clock(CLOCK_50), .divided_clocks(clk));
	 
	 assign SYSTEM_CLOCK = clk[14]; // 1526 Hz clock signal
	 // assign SYSTEM_CLOCK = CLOCK_50; // Using this for testbench
	 
	 /* If you notice flickering, set SYSTEM_CLOCK faster.
	    However, this may reduce the brightness of the LED board. */
	
	 
	 /* Set up LED board driver
	    ================================================================== */
	 logic [15:0][15:0]RedPixels; // 16 x 16 array representing red LEDs
    logic [15:0][15:0]GrnPixels; // 16 x 16 array representing green LEDs
	 logic RST;                   // reset - toggle this on startup
	 
	 assign RST = SW[9];
	 
	 /* Standard LED Driver instantiation - set once and 'forget it'. 
	    See LEDDriver.sv for more info. Do not modify unless you know what you are doing! */
	 LEDDriver Driver (.CLK(SYSTEM_CLOCK), .RST, .EnableCount(1'b1), .RedPixels, .GrnPixels, .GPIO_1);
	 
	 
	 /* LED board test submodule - paints the board with a static pattern.
	    Replace with your own code driving RedPixels and GrnPixels.
		 =================================================================== */
		 
	// processing the user input
	logic playerout;
	input_processing ip1 (.A(~KEY[3]), .clk(SYSTEM_CLOCK), .out(playerout));
	
	// producing the slower clock for the game
	logic enable1, enable2;
	clock_counter cc1 (.clk_in(SYSTEM_CLOCK), .enable(enable1), .reset(RST));
	clock_counter #(363) cc2 (.clk_in(SYSTEM_CLOCK), .enable(enable2), .reset(RST));
	
	/* For testbench
	clock_counter #(4) cc1 (.clk_in(SYSTEM_CLOCK), .enable(enable1), .reset(RST));
	clock_counter #(2) cc2 (.clk_in(SYSTEM_CLOCK), .enable(enable2), .reset(RST));
	*/
	
	// setting up bird controller
	logic [15:0] bird_out;
	bird b1 (.lights(bird_out), .push(playerout), .fall(enable1), .clk(SYSTEM_CLOCK), .reset(RST));
	
	// setting up the score keeper
	logic stop_game, incr;
	score_keeper sk1 (.green_in(GrnPixels[2][15:0]), .red_in(RedPixels[2][15:0]), .stop(stop_game), .incr, .clk(SYSTEM_CLOCK), .reset(RST));
	
	// setting up the hex drivers
	logic hex0out, hex1out, hex2out;
	single_hex_driver hd1 (.incr, .carryout(hex0out), .hexout(HEX0), .clk(SYSTEM_CLOCK), .reset(RST));
	single_hex_driver hd2 (.incr(hex0out), .carryout(hex1out), .hexout(HEX1), .clk(SYSTEM_CLOCK), .reset(RST));
	single_hex_driver hd3 (.incr(hex1out), .carryout(hex2out), .hexout(HEX2), .clk(SYSTEM_CLOCK), .reset(RST));
	difficulty_display dd1 (.in(SW[2:0]), .out(HEX5));
	
	// Setting up the column drivers
	logic [15:0] pattern;
	logic [15:0][15:0] column_out;
	pattern_generator pg1 (.out(pattern), .difficulty_in(SW[2:0]), .clk(SYSTEM_CLOCK), .enable(enable2), .reset(RST));
	column_driver cd1 (.pattern_in(pattern), .out(column_out), .clk(SYSTEM_CLOCK), .enable(enable2), .reset(RST));
	
	// setting up the screen controller
	screen_controller sc1 (.pipe_in(column_out), .bird_in(bird_out), .switch(stop_game), .red_out(RedPixels), .green_out(GrnPixels), .clk(SYSTEM_CLOCK), .reset(RST));
	
	
endmodule 


module DE1_SoC_testbench();
	logic CLOCK_50;
	logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	logic [9:0] LEDR;
	logic [3:0] KEY;
	logic [9:0] SW;
	logic [35:0] GPIO_1;

	DE1_SoC dut (.CLOCK_50, .HEX0, .HEX1, .HEX2, .HEX3, .HEX4, .HEX5, .KEY, .LEDR,.SW, .GPIO_1);
	
	// Set up a simulated clock.
	parameter CLOCK_PERIOD = 100;
	initial begin
		CLOCK_50 <= 0;
		forever #(CLOCK_PERIOD/2) CLOCK_50 <= ~CLOCK_50; // Forever toggle the clock
	end
	
	// Test the design
	initial begin
		SW[9] <= 1; SW[2] <= 1; SW[1] <= 1; SW[0] <= 1; KEY[3] <= 1; repeat(10) @(posedge CLOCK_50);
		SW[9] <= 0;  @(posedge CLOCK_50); // reset the entire module; set up difficulty
		
		KEY[3] <= 1; @(posedge CLOCK_50);
		KEY[3] <= 0; @(posedge CLOCK_50);
		KEY[3] <= 1; @(posedge CLOCK_50);
		KEY[3] <= 0; @(posedge CLOCK_50);
		KEY[3] <= 1; @(posedge CLOCK_50);
		KEY[3] <= 0; @(posedge CLOCK_50);
		KEY[3] <= 1; @(posedge CLOCK_50);
		KEY[3] <= 0; @(posedge CLOCK_50);
		KEY[3] <= 1; @(posedge CLOCK_50);
		KEY[3] <= 0; @(posedge CLOCK_50);
		
		KEY[3] <= 1; repeat(20) @(posedge CLOCK_50);
		$stop; // End the simulation.
	end
endmodule

