
//Note: lowest 2 HEX digits will reflect lower 8 bits of switch input
//Upper 4 HEX digits will reflect value in the accumulator


module Lab4toplevel   (
	input  logic 		clk, 
	input  logic		reset, 
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
	
	

    
	// Allows the register to load once, and not during full duration of button press
	// ie. converts an active low button press to a single clock cycle active high event
	negedge_detector run_once ( 
		.clk	(clk), 
		.in     (run_s), 
		.out    (load)
	);

	// Register unit that holds the accumulated sum
	load_reg #(
	   .DATA_WIDTH(17) // specifying the data width of register through a parameter
	) Register_unit ( 
		.clk		(clk), 
		.reset		(reset_s), 
		.load		(load), 
		.data_i		(s), 
		
		.data_q   	(out)
	);

	// Addition unit
	adder (  
		.a	 	(sw_s), 
		.b	 	(out[15:0]), 
		.cin 	(1'b0), 
		.cout	(s[16]), 
		.s   	(s[15:0]) 
	);

	// Hex units that display contents of sw and sum register in hex
	hex_driver hex_a (
		.clk		(clk),
		.reset		(reset_s),
		.in			({Aval[7:4], Aval[3:0]}),
		.hex_seg	(hex_segA),
		.hex_grid	(hex_gridA)
	);
	
	hex_driver hex_b (
		.clk		(clk),
		.reset		(reset_s),
		.in			({ Bval[7:4], Bval[3:0]}),
		.hex_seg	(hex_segB),
		.hex_grid	(hex_gridB)
	);
	
	// Synchchronizers/debouncers
	sync_debounce button_sync [1:0] (
	   .clk    (clk),
	   
	   .d      ({reset, run_i}),
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
