moduole flipflop_x(input Din, Clk, load, reset
                 output Qout);
	logic Din;

	always_ff @ (posedge clk)
	begin
		Q = Din;
	end

	always_comb begin
		if(reset)
			Din = 1'b0;
		else if(load)
			Din = D;
		else
			Din = Q;
	end 

endmodule


