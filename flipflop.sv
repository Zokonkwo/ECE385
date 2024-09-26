moduole flipflop_x(input D, Clk, load, reset
                 output Q);
	logic Din;

	always_ff @ (posedge clk)
	begin
		dout = Din;
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


