module D_FF_R (q, d, clk, reset);
	input logic d, clk, reset;
	output logic q;
	
	always_ff @(posedge clk) begin
		if (reset)
			q <= 0;
		else
			q <= d;
	end

endmodule 