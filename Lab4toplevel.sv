
//Note: lowest 2 HEX digits will reflect lower 8 bits of switch input
//Upper 4 HEX digits will reflect value in the accumulator


module Lab4toplevel   (
	input  logic 		clk, 
	input  logic		reset_load_clr, 
	input  logic 		run_i, // _i stands for input
	input  logic [15:0] sw_i,

	output logic        sign_LED,
	output logic [7:0]  hex_segA,
	output logic [3:0]  hex_gridA,
	output logic [7:0]  hex_segB,
	output logic [3:0]  hex_gridB	
);

	// Declare temporary values used by other modules
	logic load;
	//Out;
	logic [16:0] s;
	logic [16:0] out;
	
	// Synchronized inputs (denoted by _s in naming convention)
	logic run_s;
	logic reset_s;
	logic [15:0] sw_s;
	
	

	controllerFSM control_unit (
		.Reset_Load_Clear (Reset_Load_Clear);
		.run (run_s),
		.Clk (Clk),
		.M (Bval[0]),///////correct???
		.shift (Shift),
		.Add (Add),
		.Sub (Sub),
		.Clr (Clr),
		.LoadB (LoadB),
	);

	
	// Allows the register to load once, and not during full duration of button press
	// ie. converts an active low button press to a single clock cycle active high event
	negedge_detector run_once ( 
		.clk	(clk), 
		.in     (run_s), 
		.out    (load)
	);

	
	reg_8 #(
		.DATA_WIDTH(8) // specifying the data width of register through a parameter
	) reg_B ( 
		.Clk		(Clk), 
		.Reset		(Reset_Load_Clear), 
		.Load		(LoadB), 
		.D		(sw_s[7:0]),
		.Shift_In       (Aval[0])
		.Shift_En       (Shift)       
		
		.Data_Out   	(Bval[7:0])
	);

	reg_8 #(
		.DATA_WIDTH(9) // specifying the data width of register through a parameter
	) reg_A ( 
		.Clk		(Clk), 
		.Reset		(reset_s), 
		.Load		(0), 
		.D		(0), 
		.Shift_In       (X)
		.Shift_En       (Shift) 
		
		.Data_Out  	(Aval[7:0])
	);

	reg_8 #(
		.DATA_WIDTH(1) // specifying the data width of register through a parameter
	) reg_X ( 
		.Clk		(Clk), 
		.Reset		(Reset_Load_Clear), 
		.Load		(load), 
		.D		(sw_s[7:0]), 
		.Shift_In       (s[8]),
		.Shift_En       (Shift_En) 
		
		.Data_Out  	(Aval[7:0])
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
		.clk		(clk),
		.reset		(Reset_Load_Clear),
		.in			({Aval[7:4], Aval[3:0]}),
		.hex_seg	(hex_segA),
		.hex_grid	(hex_gridA)
	);
	
	HexDriver hex_b (
		.clk		(clk),
		.reset		(Reset_Load_Clear),
		.in			({ Bval[7:4], Bval[3:0]}),
		.hex_seg	(hex_segB),
		.hex_grid	(hex_gridB)
	);
	
	// Synchchronizers/debouncers
	sync_debounce button_sync [1:0] (
	   .clk    (clk),
	   
	   .d      ({reset_load_clr, run_i}),
	   .q      ({reset_s, run_s})
	);
	
		
	load_reg #(
	   .DATA_WIDTH(16) // specifying the data width of synchronizer through a parameter
	) sw_sync ( 
		.clk		(clk), 
		.reset		(1'b0), // there is no reset for the inputs, so hardcode 0
		.load		(1'b1), // always load data_i into the register
		.data_i		(sw_i), 
		
		.data_q   	(sw_s) 
	);
	
	assign sign_LED = out[16]; // the sign bit of the output
		
endmodule
