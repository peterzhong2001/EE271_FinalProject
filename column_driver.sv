// send pattern_out to both the next column driver and to the LEDs
module column_driver (pattern_in, out, clk, enable, reset);

	input logic enable, clk, reset;
	input logic [15:0] pattern_in;
	output logic [15:0][15:0] out;
	
	
	always_ff @(posedge clk) begin
		if (reset)
			out <= '0;
		else if (enable) begin
			out[15] <= pattern_in;
			out[14] <= out[15];
			out[13] <= out[14];
			out[12] <= out[13];
			out[11] <= out[12];
			out[10] <= out[11];
			out[9] <= out[10];
			out[8] <= out[9];
			out[7] <= out[8];
			out[6] <= out[7];
			out[5] <= out[6];
			out[4] <= out[5];
			out[3] <= out[4];
			out[2] <= out[3];
			out[1] <= out[2];
			out[0] <= out[1];
		end
		else
			out <= out;
	end
endmodule 