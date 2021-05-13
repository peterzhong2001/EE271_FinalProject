module difficulty_display (in, out);
	input logic [2:0] in;
	output logic [6:0] out;
	
	logic [6:0] hex1, hex2, hex3, hex4;
	assign hex1 = 7'b1111001; // 1
	assign hex2 = 7'b0100100; // 2
	assign hex3 = 7'b0110000; // 3
	assign hex4 = 7'b0011001; // 4
	
	always_comb begin
		case (in)
			3'b000: out = hex1;
			3'b001: out = hex2;
			3'b010: out = hex2;
			3'b011: out = hex3;
			3'b100: out = hex2;
			3'b101: out = hex3;
			3'b110: out = hex3;
			3'b111: out = hex4;
			default: out = hex1;
		endcase
	end
endmodule 