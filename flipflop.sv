
module flipflop_x(input logic D_in, Clk, load, reset,
                 output logic Qout);

    logic Din;
	always_ff @ (posedge Clk)
	begin
		Qout = D_in;
	end

	always_comb begin
		if(reset)
			Din = 1'b0;
		else if(load)
			Din = D_in;
		else
			Din = Qout;
	end 

endmodule
