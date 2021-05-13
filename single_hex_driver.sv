 module single_hex_driver (incr, carryout, hexout, clk, reset);
 
	input logic incr, reset, clk;
	output logic [6:0] hexout;
	output logic carryout;
	
	enum {zero, one, two, three, four, five, six, seven, eight, nine} ps, ns;
	
	logic [6:0] hex0, hex1, hex2, hex3, hex4, hex5, hex6, hex7, hex8, hex9;
	assign hex0 = 7'b1000000; // 0
	assign hex1 = 7'b1111001; // 1
	assign hex2 = 7'b0100100; // 2
	assign hex3 = 7'b0110000; // 3
	assign hex4 = 7'b0011001; // 4
	assign hex5 = 7'b0010010; // 5
	assign hex6 = 7'b0000010; // 6
	assign hex7 = 7'b1111000; // 7
	assign hex8 = 7'b0000000; // 8
	assign hex9 = 7'b0010000; // 9
	
	// Next state logic
	always_comb begin
		case(ps)
			zero: if (incr) ns = one;
					else ns = zero;
			one: if (incr) ns = two;
					else ns = one;
			two: if (incr) ns = three;
					else ns = two;
			three: if (incr) ns = four;
					else ns = three;
			four: if (incr) ns = five;
					else ns = four;
			five: if (incr) ns = six;
					else ns = five;
			six: if (incr) ns = seven;
					else ns = six;
			seven: if (incr) ns = eight;
					else ns = seven;
			eight: if (incr) ns = nine;
					else ns = eight;
			nine: if (incr) ns = zero;
					else ns = nine;
		endcase
	end
	
	// Output logic for hex display
	always_comb begin
		case(ps)
			zero: hexout = hex0;
			one: hexout = hex1;
			two: hexout = hex2;
			three: hexout = hex3;
			four: hexout = hex4;
			five: hexout = hex5;
			six: hexout = hex6;
			seven: hexout = hex7;
			eight: hexout = hex8;
			nine: hexout = hex9;
		endcase
	end
 
	//output logic for carryout
	always_comb begin
		case(ps)
			nine: if (incr) carryout = 1'b1;
					else carryout = 1'b0;
			default: carryout = 1'b0;
		endcase
	end
	
	//DFF
	always_ff @(posedge clk) begin
		if (reset)
			ps <= zero;
		else
			ps <= ns;
	end
 
 endmodule 