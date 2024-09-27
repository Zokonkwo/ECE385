
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
	logic load, loadb;
	logic add, sub, clr;
	logic shift, shift_inA, shift_inB, shift_tmp;

	//Out;
	logic [16:0] s;
	logic [16:0] out;
	logic cout;
	
	// Synchronized inputs (denoted by _s in naming convention)
	logic run_s;
	logic reset_s;
	logic [8:0] XA ;
	logic [8:0] sw ;
	
//loadB never goes high
//too many parameter overmides for module reg_8

	controllerFSM control_unit (
		.Reset_Load_Clr (Reset_Load_Clr),
		.run (run_i),
		.Clk (Clk), 		//Clk gets put into Clk
		.M_val (Bval[0]), 	//Bval[0] gets put into M_val
		.Shift (shift), 	//output Shift get stored at wire shift to be used other places for inputs
		.Add (add), 		//output Add get stored at wire add to be used other places for inputs
		.Sub (sub), 		//output Sub get stored at wire sub to be used other places for inputs
		.Clr (clr), 		//output Clr get stored at wire clr to be used other places for inputs
		.LoadB (loadb) 		//output LoadB get stored at wire loadb to be used other places for inputs
	);

//where do we put the clr signal for the registers --> what does it mean exactly
//timing seems to be off when we are in state to everything else updating

    flipflop_x flipflop(
        .D_in (s[8]),
        .Clk (Clk),
        .load (shift), //what signal should be sent to tell the flipflop to load in the new signal
        .reset (Reset_Load_Clr),
        .Qout (shift_inA)

    );
	
	// Allows the register to load once, and not during full duration of button press
	// ie. converts an active low button press to a single clock cycle active high event
	negedge_detector run_once ( 
		.Clk	(Clk), 
		.in     (run_s), 
		.out    (load)
	);

	
	reg_8 reg_B ( 
		.Clk		(Clk), 
		.Reset		(1'b0), 
		.Load		(loadb), 
		.D		    (sw_i),
		.Shift_In   (shift_inB),
		.Shift_En   (shift),
		.Shift_Out 	(shift_tmp),    
		.Data_Out   (Bval)
	);

	reg_8
	 reg_A ( 
		.Clk		(Clk), 
		.Reset		(reset_s), 
		.Load		(add), 
		.D		    (s[7:0]), 
		.Shift_In   (shift_inA),
		.Shift_En   (shift), 
		.Shift_Out 	(shift_inB),
		.Data_Out  	(Aval)
	);



	// Addition/subtraction unit

	ripple_adder_9 ra_9 (
		.XA  ({Aval[7], Aval}), //sign extension
		.sw  ({Bval[7], Bval}), //sign extension
		.fn  (sub),
		.s  (s[8:0]),
		.c_out  (cout)
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
	   
	   .d      ({Reset_Load_Clr, run_i}),
	   .q      ({reset_s, run_s})
	);
	
		
	reg_8 // specifying the data width of synchronizer through a parameter
	 sw_sync ( 
		.Clk		(Clk), 
		.Reset		(1'b0), // there is no reset for the inputs, so hardcode 0
		.Load		(1'b1), // always load data_i into the register
		.D		    (sw_i) 
		
	//	.Data_Out  	(sw_i) 
	);
	
	assign sign_LED = out[16]; // the sign bit of the output
		
endmodule
