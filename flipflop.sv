moduole flipflop_x(input D_in, Clk, load, reset
                 output Qout);
	logic Din;

	always_ff @ (posedge clk)
	begin
		Qout = Din;
	end

	always_comb begin
		if(reset)
			Din = 1'b0;
		else if(load)
			Din = D_in;
		else
			Din = Q;
	end 

endmodule


