// Slows down the clock to the desired rate. Currently, game clock is at 2Hz
module clock_counter #(parameter CYCLE = 762) (clk_in, enable, reset);

	input logic clk_in, reset;
	output logic enable;
	
	integer count;
	
	always_ff @(posedge clk_in) begin
		if (count == 0 | reset)
			count <= CYCLE;
		else
			count <= count - 1;
	end

	assign enable = (count == 0);
endmodule 