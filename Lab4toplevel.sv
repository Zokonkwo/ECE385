
//Note: lowest 2 HEX digits will reflect lower 8 bits of switch input
//Upper 4 HEX digits will reflect value in the accumulator


module Lab4toplevel   (
	input  logic 		Clk, 
	input  logic		Reset_Load_Clr, 
	input  logic 		run_i, // _i stands for input
	input  logic [7:0] sw_i,
	
	

	output logic        sign_LED,
	output logic [7:0]  hex_segA,
	output logic [3:0]  hex_gridA,
	output logic [7:0] Aval, Bval
);

	// Declare temporary values used by other modules///////////////why???????????for c1-c8 too??
	logic load;
	logic LoadB;
	//Out;
	logic [16:0] s;
	logic [16:0] out;
	
	// Synchronized inputs (denoted by _s in naming convention)
	logic run_s;
	logic reset_s;
	logic [8:0] XA ;
	logic [8:0] sw ;
	

	controllerFSM control_unit (
		.Reset_Load_Clr (Reset_Load_Clr),
		.run (run_s),
		.Clk (Clk),
		.M (Bval[0]),
		.Shift (Shift),
		.Add (Add),
		.Sub (Sub),
		.Clr (Clr),
		.LoadB (LoadB)
	);


    flipflop_x flipflop(
        .D_in (s[8]),
        .Clk (Clk),
        .load (load),
        .reset (Reset_Load_Clr),
        .Qout (Aval[7])

    );
	
	// Allows the register to load once, and not during full duration of button press
	// ie. converts an active low button press to a single clock cycle active high event
	negedge_detector run_once ( 
		.Clk	(Clk), 
		.in     (run_s), 
		.out    (load)
	);

	
	reg_8 #(8) reg_B ( 
		.Clk		(Clk), 
		.Reset		(Reset_Load_Clr), 
		.Load		(LoadB), 
		.D		    (sw_i[7:0]),
		.Shift_In   (Aval[0]),
		.Shift_En   (Shift),       
		.Data_Out   (Bval)
	);

	reg_8 #(8)
	 reg_A ( 
		.Clk		(Clk), 
		.Reset		(Reset_Load_Clr), 
		.Load		(0), 
		.D		    (0), 
		.Shift_In   (s[8]),
		.Shift_En   (Shift), 
		
		.Data_Out  	(Aval)
	);



	// Addition/subtraction unit

	ripple_adder_9 ra_9 (
		.XA  (XA[8:0]),
		.sw  (sw[8:0]),
		.fn  (fn),
		.s  (s[8:0]),
		.c_out  (c_out)
	);
	
	HexDriver hex_a (
		.Clk		(Clk),
		.reset		(Reset_Load_Clr),
		.in			({Bval[7:4], Bval[3:0], Aval[7:4], Aval[3:0]}),
		.hex_seg	(hex_segA),
		.hex_grid	(hex_gridA)
	);
	

	
	// Synchchronizers/debouncers
	sync_debounce button_sync [1:0] (
	   .Clk    (Clk),
	   
	   .d      ({reset_load_clr, run_i}),
	   .q      ({reset_s, run_s})
	);
	
		
	reg_8 #(8) // specifying the data width of synchronizer through a parameter
	 sw_sync ( 
		.Clk		(Clk), 
		.Reset		(1'b0), // there is no reset for the inputs, so hardcode 0
		.Load		(1'b1), // always load data_i into the register
		.D		(sw_i), 
		
		.Data_Out  	(sw_i) 
	);
	
	assign sign_LED = out[16]; // the sign bit of the output
		
endmodule
