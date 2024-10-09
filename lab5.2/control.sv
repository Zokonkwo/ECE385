//------------------------------------------------------------------------------
// Company:          UIUC ECE Dept.
// Engineer:         Stephen Kempf
//
// Create Date:    17:44:03 10/08/06
// Design Name:    ECE 385 Given Code - Incomplete ISDU for SLC-3
// Module Name:    Control - Behavioral
//
// Comments:
//    Revised 03-22-2007
//    Spring 2007 Distribution
//    Revised 07-26-2013
//    Spring 2015 Distribution
//    Revised 02-13-2017
//    Spring 2017 Distribution
//    Revised 07-25-2023
//    Xilinx Vivado
//	  Revised 12-29-2023
// 	  Spring 2024 Distribution
// 	  Revised 6-22-2024
//	  Summer 2024 Distribution
//	  Revised 9-27-2024
//	  Fall 2024 Distribution
//------------------------------------------------------------------------------

module control (
	input logic		clk, 
	input logic		reset,

	input logic  [15:0]	ir,
	input logic		ben,

	input logic 		continue_i,
	input logic 		run_i,

	input logic 		n,z,p,

	output logic		ld_mar,
	output logic		ld_mdr,
	output logic		ld_ir,
	output logic		ld_pc,
	output logic            ld_led,
	output logic  	        ld_ben,//added
	output logic 		ld_reg,
	output logic 		ld_cc,
						
	//output logic		gate_pc,
	//output logic		gate_mdr,
	
	//You should add additional control signals according to the SLC-3 datapath design

	output logic		mem_mem_ena, // Mem Operation Enable
	output logic		mem_wr_ena,  // Mem Write Enable

	output logic 		sr1_select, addr1_mux_select, dr_select, sr2_mux_select, //2 bit mux selections
	output logic [1:0]	pcmux, addr2_mux_select, aluk_in,  //3 bit mux selections
	output logic [3:0]	data_select //data bus selection

			
);

	enum logic [5:0] { //was 4
		halted, 
		pause_ir1,
		pause_ir2, 
		s_18, 
		s_33_1,
		s_33_2,
		s_33_3,
		s_35,
		s_32,
		s_1,
		s_1_i,
		s_5,
		s_5_i,
		s_9,
		s_6,
		s_25_1,
		s_25_2,
		s_25_3,
		s_27,
		s_7,
		s_23,
		s_16_1,
		s_16_2,
		s_16_3,
		s_4,
		s_21,
		s_12,
		s_0,
		s_22
		
	} state, state_nxt;   // Internal state logic


	always_ff @ (posedge clk)
	begin
		if (reset) 
			state <= halted;
		else 
			state <= state_nxt;
	end
   
	always_comb
	begin 
		
		// Default controls signal values so we don't have to set each signal
		// in each state case below (If we don't set all signals in each state,
		// we can create an inferred latch)
		ld_mar = 1'b0;
		ld_mdr = 1'b0;
		ld_ir = 1'b0;
		ld_pc = 1'b0;
		ld_led = 1'b0;
		ld_reg = 1'b0;
		ld_cc = 1'b0;
		ld_ben = 1'b0;
		
		// gate_pc = 1'b0;
		// gate_mdr = 1'b0;
		 
		pcmux = 2'b00;
		
	
		// Assign relevant control signals based on current state
		//relevant control signals already set for the three fetch states (Week 1 state machine is orivded) 
		//we need to fill out the data paths so we ahve the xetra registers and a couple of 
		//extra muxes we need) 
		//fill in the relevant modules within the cpu module such that it resembles the data path of 
		// the slides (for minimum fetch operation) 
		case (state)
			halted: ; 
			s_18 : 
				begin 
					//gate_pc = 1'b1;
					ld_mar = 1'b1;
					pcmux = 2'b00;
					ld_pc = 1'b1;
					data_select = 4'b0100; //GatePC
				end
			s_33_1, s_33_2, s_33_3 : //you may have to think about this as well to adapt to ram with wait-states
				begin
					mem_mem_ena = 1'b1;
					ld_mdr = 1'b1;
				end
			s_35 : 
				begin 
					//gate_mdr = 1'b1;
					ld_ir = 1'b1;
					data_select = 4'b0001; //GateMDR

				end
			pause_ir1: ld_led = 1'b1; 
			pause_ir2: ld_led = 1'b1; 
			// you need to finish the rest of state output logic..... 
			
			s_32 :
			begin
			  ld_mar = 1'b0;
			  ld_mdr = 1'b0;
			  ld_ir = 1'b0;
			  ld_pc = 1'b0;
		   	  ld_led = 1'b0;
		   	  ld_reg = 1'b0;
		   	  ld_cc = 1'b0;
			  ld_ben = 1'b1;
		
			  // gate_pc = 1'b0;
			  // gate_mdr = 1'b0;
		 
			  pcmux = 2'b00;
			  dr_select = 1'b0; 
			  sr1_select = 1'b0; 
			  sr2_mux_select = 1'b0; 
			  addr1_mux_select = 1'b0;
			  addr2_mux_select = 2'b00;
			  aluk_in = 2'b00;   
			  data_select = 4'b0000; //Default x
			end
			
			s_1 :
			 begin
			  ld_mar = 1'b0;
		          ld_mdr = 1'b0;
		          ld_ir = 1'b0;
		          ld_pc = 1'b0;
		          ld_led = 1'b0;
			  ld_reg = 1'b1; //load into register file
			  ld_cc = 1'b1; //load cc
			  ld_ben = 1'b0;
		
		          // gate_pc = 1'b0;
		          // gate_mdr = 1'b0;

			  //add in sr2_in	 
		          pcmux = 2'b00;
			  dr_select = 1'b0; //select ir[11:9]
			  sr1_select = 1'b1; //select ir[8:6]
			  sr2_mux_select = 1'b0; //ir[5] = 0
			  addr1_mux_select = 1'b0;
			  addr2_mux_select = 2'b00;
			  aluk_in = 2'b00;   //select ADD
			  data_select = 4'b0010; //GateALU
			end
			
			s_1_i :
			 begin
			  ld_mar = 1'b0;
		          ld_mdr = 1'b0;
		          ld_ir = 1'b0;
		          ld_pc = 1'b0;
		          ld_led = 1'b0;
		          ld_reg = 1'b1; //load into register file
			  ld_cc = 1'b1; //load cc
			  ld_ben = 1'b0;
				 
		          // gate_pc = 1'b0;
		          // gate_mdr = 1'b0;
			
		          pcmux = 2'b00;
			  dr_select = 1'b0; //select ir[11:9]
			  sr1_select = 1'b1; //select ir[8:6]
			  sr2_mux_select = 1'b1; //ir[5] = 1
			  addr1_mux_select = 1'b0;
			  addr2_mux_select = 2'b00;
			  aluk_in = 2'b00;   //select ADD
			  data_select = 4'b0010; //GateALU

				
			end
			
			s_5 :
			begin
			  ld_mar = 1'b0;
		          ld_mdr = 1'b0;
		          ld_ir = 1'b0;
		          ld_pc = 1'b0;
		          ld_led = 1'b0;
			  ld_reg = 1'b1; //load reg file
		          ld_cc = 1'b1; //load cc
			  ld_ben = 1'b0;
		          // gate_pc = 1'b0;
		          // gate_mdr = 1'b0;

			  //add sr2_in
		          pcmux = 2'b00;
			  dr_select = 1'b0; //select ir[11:9]
			  sr1_select = 1'b1; //select ir[8:6]
			  sr2_mux_select = 1'b0; //ir[5] = 0
			  addr1_mux_select = 1'b0;
			  addr2_mux_select = 2'b00;
			  aluk_in = 2'b01;   //select AND
			  data_select = 4'b0010; //GateALU
			end

			s_5_i :
			begin
			  ld_mar = 1'b0;
		          ld_mdr = 1'b0;
		          ld_ir = 1'b0;
		          ld_pc = 1'b0;
		          ld_led = 1'b0;
			  ld_reg = 1'b1; //load reg file
		          ld_cc = 1'b1; //load cc
			  ld_ben = 1'b0;
		          // gate_pc = 1'b0;
		          // gate_mdr = 1'b0;
		 
		          pcmux = 2'b00;
			  dr_select = 1'b0; //select ir[11:9]
			  sr1_select = 1'b0; //select ir[11:9]
			  sr2_mux_select = 1'b1; //ir[5] = 1
			  addr1_mux_select = 1'b0;
			  addr2_mux_select = 2'b00;
			  aluk_in = 2'b01;   //select AND
			  data_select = 4'b0010; //GateALU
			end
			
			s_9 :
			begin
			  ld_mar = 1'b0;
		          ld_mdr = 1'b0;
		          ld_ir = 1'b0;
		          ld_pc = 1'b0;
		          ld_led = 1'b0;
			  ld_reg = 1'b1; //load into register file
		          ld_cc = 1'b1; //load cc
			  ld_ben = 1'b0;
		          // gate_pc = 1'b0;
		          // gate_mdr = 1'b0;
		 
		          pcmux = 2'b00;
			  dr_select = 1'b0; //select ir[11:9]
			  sr1_select = 1'b1; //select ir[8:6]
			  aluk_in = 2'b11;   //select NOT
			  sr2_mux_select = 1'b0; 
			  addr1_mux_select = 1'b0;
			  addr2_mux_select = 2'b00;
			  data_select = 4'b0010;  //activate GateALU
			end
			
			s_6 :
			begin
			  ld_mar = 1'b1; //load mar
		          ld_mdr = 1'b0;
		          ld_ir = 1'b1; //load ir
		          ld_pc = 1'b0;
		          ld_led = 1'b0;
			  ld_reg = 1'b0;
			  ld_cc = 1'b0;
			  ld_ben = 1'b0;
		
		          // gate_pc = 1'b0;
		          // gate_mdr = 1'b0;
		 
		          pcmux = 2'b00;
			  dr_select = 1'b0; 
			  sr1_select = 1'b1; //SR1MUX select chooses output 1 being IR[8:6]
			  sr2_mux_select = 1'b0; 
			  addr1_mux_select = 1'b1; //addr1mux select chooses input 1 being sr1 out
			  addr2_mux_select = 2'b01; //addr2mux selects the [5:0] sign extension
			  aluk_in = 2'b00; 
			  data_select = 4'b1000; //GateMARMUX	
			end
			
			s_25_1, s_25_2, s_25_3 :
			begin
			  ld_mar = 1'b0;
		          ld_mdr = 1'b1; //load mdr
		          ld_ir = 1'b0;
		          ld_pc = 1'b0;
		          ld_led = 1'b0;
			  ld_reg = 1'b0;
			  ld_cc = 1'b0;
			  ld_ben = 1'b0;
			  
			  mem_mem_ena = 1'b1;
		          // gate_pc = 1'b0;
		          // gate_mdr = 1'b0;
		 
		          pcmux = 2'b00;
			  dr_select = 1'b0; 
			  sr1_select = 1'b0; 
			  sr2_mux_select = 1'b0; 
			  addr1_mux_select = 1'b0;
			  addr2_mux_select = 2'b00;
			  aluk_in = 2'b00;   
			  data_select = 4'b0000; //Default x
			end
			
			s_27 :
			begin
			  ld_mar = 1'b0;
		          ld_mdr = 1'b0;
		          ld_ir = 1'b0;
		          ld_pc = 1'b0;
		          ld_led = 1'b0;
			  ld_reg = 1'b1; //load reg
			  ld_cc = 1'b0;
			  ld_ben = 1'b0;
		
		          // gate_pc = 1'b0;
		          // gate_mdr = 1'b0;
		 
		          pcmux = 2'b00;
			  dr_select = 1'b0;  //select ir[11:9]
			  sr1_select = 1'b1; //select ir[8:6] 
			  sr2_mux_select = 1'b0; 
			  addr1_mux_select = 1'b0;
			  addr2_mux_select = 2'b00;
			  aluk_in = 2'b00;   
			  data_select = 4'b0001; //GateMDR
			end
			
			s_7 :  //start of STR
			begin
			  //mdr_in = bus;//we dont need to include bus logic at top since cpu handles it
			  ld_mar = 1'b1; //set laod mar high to load bus data to mar register
		          ld_mdr = 1'b0;
		          ld_ir = 1'b0;
		          ld_pc = 1'b0;
		          ld_led = 1'b0;
			  ld_reg = 1'b0;
			  ld_cc = 1'b0;
			  ld_ben = 1'b0;
		
		          // gate_pc = 1'b0;
		          // gate_mdr = 1'b0;
		 
		          pcmux = 2'b00;
			  dr_select = 1'b0; 
			  sr1_select = 1'b1; //SR1MUX select chooses output 1 being IR[8:6]
			  sr2_mux_select = 1'b0; 
			  addr1_mux_select = 1'b1; //addr1mux select chooses input 1 being sr1 out
			  addr2_mux_select = 2'b01; //addr2 mux select chooses sext[5:0]
			  aluk_in = 2'b00;   
			  data_select = 4'b1000; //Default GateMARMUX
			end
			
			s_23 :
			begin
			  ld_mar = 1'b0;
		          ld_mdr = 1'b1;
		          ld_ir = 1'b0;
		          ld_pc = 1'b0;
		          ld_led = 1'b0;
			  ld_reg = 1'b0;
			  ld_cc = 1'b0;
			  ld_ben = 1'b0;

			  mem_mem_ena = 1'b0;
		          // gate_pc = 1'b0;
		          // gate_mdr = 1'b0;
		 
		          pcmux = 2'b00;
			  dr_select = 1'b0; 
			  sr1_select = 1'b0; 
			  sr2_mux_select = 1'b0; 
			  addr1_mux_select = 1'b0;
			  addr2_mux_select = 2'b00;
			  aluk_in = 2'b10; //ALUK 10 = pass  
			  data_select = 4'b0010; //GateALU
			end
			
			s_16_1, s_16_2, s_16_3 :
			begin
			  ld_mar = 1'b0;
		          ld_mdr = 1'b0;
		          ld_ir = 1'b0;
		          ld_pc = 1'b0;
		          ld_led = 1'b0;
			  ld_reg = 1'b0;
			  ld_cc = 1'b0;
			  ld_ben = 1'b0;
		
		          gate_pc = 1'b0;
		          gate_mdr = 1'b0;
		 
		          pcmux = 2'b00;
			  dr_select = 1'b0; 
			  sr1_select = 1'b0; 
			  sr2_mux_select = 1'b0; 
			  addr1_mux_select = 1'b0;
			  addr2_mux_select = 2'b00;
			  aluk_in = 2'b00;   
			  data_select = 4'b0000; //Default x
			end
			
			s_4 :
			begin
			  ld_mar = 1'b0;
		          ld_mdr = 1'b0;
		          ld_ir = 1'b0; 
		          ld_pc = 1'b0; 
		          ld_led = 1'b0;
			  ld_reg = 1'b1; //load reg
			  ld_cc = 1'b0;
			  ld_ben = 1'b0;
				
		
		          // gate_pc = 1'b0;
		          // gate_mdr = 1'b0;
		 
		          pcmux = 2'b00; 
			  dr_select = 1'b1;  //select 111
			  sr1_select = 1'b0; 
			  sr2_mux_select = 1'b0; 
			  addr1_mux_select = 1'b0; 
			  addr2_mux_select = 2'b00; 
			  aluk_in = 2'b00;  
			  data_select = 4'b0100; //GatePC
			end
			
			s_21 :
			begin
			  ld_mar = 1'b0;
		          ld_mdr = 1'b0;
		          ld_ir = 1'b1; //load ir
		          ld_pc = 1'b1; //load pc
		          ld_led = 1'b0;
			  ld_reg = 1'b1; 
			  ld_cc = 1'b0;
			  ld_ben = 1'b0;
		
		          // gate_pc = 1'b0;
		          // gate_mdr = 1'b0;
		 
		          pcmux = 2'b01; //select adder result
			  dr_select = 1'b0; 
			  sr1_select = 1'b0; 
			  sr2_mux_select = 1'b0; 
			  addr1_mux_select = 1'b0; //select pc
			  addr2_mux_select = 2'b11; //select sext3
			  aluk_in = 2'b00;   
			 data_select = 4'b0000; //Default x
			end
			
			s_12 :
			begin
			  ld_mar = 1'b0;
		          ld_mdr = 1'b0;
		          ld_ir = 1'b0;
		          ld_pc = 1'b1; //load pc
		          ld_led = 1'b0;
			  ld_reg = 1'b0;
			  ld_cc = 1'b0;
			  ld_ben = 1'b0;
		
		          // gate_pc = 1'b0;
		          // gate_mdr = 1'b0;
		 
		          pcmux = 2'b10;
			  dr_select = 1'b0; 
			  sr1_select = 1'b1; 
			  sr2_mux_select = 1'b0; 
			  addr1_mux_select = 1'b0;
			  addr2_mux_select = 2'b00;
			  aluk_in = 2'b10;   //pass through
			  data_select = 4'b0010; //GateALU
			end
			
			s_0 :
			begin
			  ld_mar = 1'b0;
		          ld_mdr = 1'b0;
		          ld_ir = 1'b0;
		          ld_pc = 1'b0;
		          ld_led = 1'b0;
			  ld_reg = 1'b0;
			  ld_cc = 1'b0;
			  ld_ben = 1'b0;
		
		          // gate_pc = 1'b0;
		          // gate_mdr = 1'b0;
		 
		          pcmux = 2'b00;
			  dr_select = 1'b0; 
			  sr1_select = 1'b0; 
			  sr2_mux_select = 1'b0; 
			  addr1_mux_select = 1'b0;
			  addr2_mux_select = 2'b00;
			  aluk_in = 2'b00;   
			  data_select = 4'b0000; //Default x
			end
			
			s_22 :
			begin
			  ld_mar = 1'b0;
		          ld_mdr = 1'b0;
		          ld_ir = 1'b0;
		          ld_pc = 1'b1;
		          ld_led = 1'b0;
			  ld_reg = 1'b0;
			  ld_cc = 1'b0;
			  ld_ben = 1'b0;
		
		          // gate_pc = 1'b0;
		          // gate_mdr = 1'b0;
		 
		          pcmux = 2'b01;
			  dr_select = 1'b0; 
			  sr1_select = 1'b0; 
			  sr2_mux_select = 1'b0; 
			  addr1_mux_select = 1'b0;
			  addr2_mux_select = 2'10;
			  aluk_in = 2'b00;   
			  data_select = 4'b0000; //Default x
			end
			
			

			default : ;
		endcase
	end 


	always_comb
	begin
		// default next state is staying at current state
		state_nxt = state;

		unique case (state)
			halted : 
				if (run_i) 
					state_nxt = s_18;
				else
				    state_nxt = halted;//added to avoid inferred latch
			s_18 : 
				state_nxt = s_33_1; //notice that we usually have 'r' here, but you will need to add extra states instead 
			s_33_1 :                 //e.g. s_33_2, etc. how many? as a hint, note that the bram is synchronous, in addition, 
				state_nxt = s_33_2;   //it has an additional output register. 
			s_33_2 :
				state_nxt = s_33_3;
			s_33_3 : 
				state_nxt = s_35;
			s_35 : 
				state_nxt = s_32;	
			s_32 :
				begin
				  if (ir[15:12] == 4'b0001 && ir[5] == 1'b0)//ADD
					state_nxt = s_1;
				  else if (ir[15:12] == 4'b0001 && ir[5] == 1'b1) //ADDi
					state_nxt = s_1_i;
				  else if (ir[15:12] == 4'b0101 && ir[5] == 1'b0) //AND
					state_nxt = s_5;
				  else if (ir[15:12] == 4'b0001 && ir[5] == 1'b1)  // ANDi
					state_nxt = s_5_i;
				  else if (ir[15:12] == 4'b1001) //NOT
					state_nxt = s_9;
				  else if (ir[15:12] == 4'b0110) //LDR
					state_nxt = s_6;
				  else if (ir[15:12] == 4'0111) //STR
					state_nxt = s_7;
				  else if (ir[15:12] == 4'b0100) //JSR
					state_nxt = s_4;
				  else if (ir[15:12] == 4'b1100) //JMP
					state_nxt = s_12;
				  else if (ir[15:12] == 4'b0000) //BR
					state_nxt = s_0;
				  else if (ir[15:12] == 4'b1101) //PSE
					state_nxt = pause_ir1;
				  else 
					state_nxt = s_18;
				end
			
			s_1 :	
				state_nxt = s_18;
			s_1_i :	
				state_nxt = s_18;
			s_5 :
				state_nxt = s_18;
			s_5_i :
				state_nxt = s_18;
			s_9 :
				state_nxt = s_18;
			s_6 :
				state_nxt = s_25_1;
			s_25_1 :
				state_nxt = s_25_2;
			s_25_2 :
				state_nxt = s_25_3;
			s_25_3 :
				state_nxt = s_27;
			s_27:
				state_nxt = s_18;
			s_7 :
				state_nxt = s_23;
			s_23 :
				state_nxt = s_16_1;
			s_16_1 :
				state_nxt = s_16_2;
			s_16_2 :
				state_nxt = s_16_3
			s_16_3 :
				state_nxt = s_18;
			s_4 :
				state_nxt = s_21;
			s_21 :
				state_nxt = s_18;
			s_12 :
				state_nxt = s_18;
			s_0 :
			  if(ben == 1)
				state_nxt = s_22;
			  else
				state_next = s_18;
			
			s_22 :
				state_nxt = s_18;
			
			
			
				
			// pause_ir1 and pause_ir2 are only for week 1 such that TAs can see 
			// the values in ir.
			pause_ir1 : 
				if (continue_i) 
					state_nxt = pause_ir2;
				else
				    state_nxt = pause_ir1;
			pause_ir2 : 
				if (~continue_i)
					state_nxt = s_18;
			     else
				    state_nxt = pause_ir2;
			// you need to finish the rest of state transition logic.....
			
			default :;
		endcase
	end
	
endmodule
