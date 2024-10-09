module testbench(); //even though the testbench doesn't create any hardware, it still needs to be a module

timeunit 10ns;  // This is the amount of time represented by #1 
timeprecision 1ns;

// These signals are internal because the processor will be 
// instantiated as a submodule in testbench.
      logic		    clk;
	  logic 		reset;
	  logic 		run_i; 
	  logic 		continue_i;
	  logic [15:0]  sw_i;

	 logic [15:0] led_o;
	 logic [7:0]  hex_seg_left;
	 logic [3:0]  hex_grid_left;
	 logic [7:0]  hex_seg_right;
	 logic [3:0]  hex_grid_right;

// To display



// Instantiating the DUT (Device Under Test)
// Make sure the module and signal names match with those in your design
processor_top processor_top(.*);	


initial begin: CLOCK_INITIALIZATION
	clk = 1'b1;
end 

// Toggle the clock
// #1 means wait for a delay of 1 timeunit, so simulation clock is 50 MHz technically 
// half of what it is on the FPGA board 

// Note: Since we do mostly behavioral simulations, timing is not accounted for in simulation, however
// this is important because we need to know what the time scale is for how long to run
// the simulation
always begin : CLOCK_GENERATION
	#1 clk = ~clk;
end

// Testing begins here
// The initial block is not synthesizable on an FPGA
// Everything happens sequentially inside an initial block
// as in a software program

// Note: Even though the testbench happens sequentially,
// it is recommended to use non-blocking assignments for most assignments because
// we do not want any dependencies to arise between different assignments in the 
// same simulation timestep. The exception is for reset, which we want to make sure
// happens first. 
initial begin: TEST_VECTORS
    continue_i = 0;
    run_i <= 0;
	reset <= 0;
	#10
	
	
	
	reset <= 1; 
	#10
	reset <= 0;
	#10
	

$finish(); 
end
endmodule
