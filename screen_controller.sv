module screen_controller(pipe_in, bird_in, switch, red_out, green_out, clk, reset);
	input logic switch, clk, reset;
	input logic [15:0] bird_in;
	input logic [15:0][15:0] pipe_in;
	output logic [15:0][15:0] red_out, green_out;
	
	enum {on, off} ps, ns;
	
	logic [15:0][15:0] end_screen, running_screen;
	
	// Assigning running screen
	assign running_screen[00] = 0;
	assign running_screen[01] = 0;
	assign running_screen[02] = bird_in;
	assign running_screen[03] = 0;
	assign running_screen[04] = 0;
	assign running_screen[05] = 0;
	assign running_screen[06] = 0;
	assign running_screen[07] = 0;
	assign running_screen[08] = 0;
	assign running_screen[09] = 0;
   assign running_screen[10] = 0;
	assign running_screen[11] = 0;
	assign running_screen[12] = 0;
	assign running_screen[13] = 0;
	assign running_screen[14] = 0;
	assign running_screen[15] = 0;
	
	assign end_screen[00] = 16'b0011111000111000;
	assign end_screen[01] = 16'b0010001001010100;
	assign end_screen[02] = 16'b0011111000110100;
	assign end_screen[03] = 16'b0000000000000000;
	assign end_screen[04] = 16'b0001111001111000;
	assign end_screen[05] = 16'b0010000000010100;
	assign end_screen[06] = 16'b0001111001111000;
	assign end_screen[07] = 16'b0000000000000000;
	assign end_screen[08] = 16'b0011111001111000;
	assign end_screen[09] = 16'b0010101000000100;
   assign end_screen[10] = 16'b0010101001111000;
	assign end_screen[11] = 16'b0000000000000100;
	assign end_screen[12] = 16'b0011111001111000;
	assign end_screen[13] = 16'b0001101001111100;
	assign end_screen[14] = 16'b0010111001010100;
	assign end_screen[15] = 16'b0000000001010100;
	
	// next state logic
	always_comb begin
		case(ps)
			on: if (switch) ns = off;
				 else ns = on;
			off: ns = off;
		endcase
	end
	
	//red output logic
	always_comb begin
		case(ps)
			on: red_out = running_screen;
			off: red_out = end_screen;
		endcase
	end
	
	//green output logic
	always_comb begin
		case(ps)
			on: green_out = pipe_in;
			default: green_out = '0;
		endcase
	end
	
	
	//DFF
	always_ff @(posedge clk) begin
		if (reset)
			ps <= on;
		else
			ps <= ns;
	end
endmodule 