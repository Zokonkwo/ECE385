//------------------------------------------------------------------------------
// Company: 		 UIUC ECE Dept.
// Engineer:		 Stephen Kempf
//
// Create Date:    
// Design Name:    ECE 385 Given Code - SLC-3 core
// Module Name:    SLC3
//
// Comments:
//    Revised 03-22-2007
//    Spring 2007 Distribution
//    Revised 07-26-2013
//    Spring 2015 Distribution
//    Revised 09-22-2015 
//    Revised 06-09-2020
//	  Revised 03-02-2021
//    Xilinx vivado
//    Revised 07-25-2023 
//    Revised 12-29-2023
//    Revised 09-25-2024
//------------------------------------------------------------------------------

module cpu (
    input   logic        clk,
    input   logic        reset,

    input   logic        run_i,
    input   logic        continue_i,
    output  logic [15:0] hex_display_debug,
    output  logic [15:0] led_o,
   
    input   logic [15:0] mem_rdata,
    output  logic [15:0] mem_wdata,
    output  logic [15:0] mem_addr,
    output  logic        mem_mem_ena,
    output  logic        mem_wr_ena
);


// Internal connections, follow the datapath block diagram and add the additional needed signals
logic ld_mar, d_mdr, ld_ir, ld_pc, ld_led; 
logic gate_pc, gate_mdr, gate_alu, gate_marmux;

logic [15:0] mar, mdr_in, mdr;   
logic [1:0] pcmux; 
logic [15:0] pc, pc_in, pc_1;

assign pc_1 = pc + 1;  
    
logic [15:0] ir;  
logic [15:0] rdata;
logic [15:0] bus;

logic [15:0] sr2_mux_in, alu_a_in, alu_b_in, adder_a_in, adder_b_in;
logic [2:0] sr1_in, sr2_in, dr_in;
    
logic ben;
logic n, z, p;

assign mem_addr = mar;
assign mem_wdata = mdr;

assign led_o = ir;
assign hex_display_debug = ir;

// State machine, you need to fill in the code here as well
// .* auto-infers module input/output connections which have the same name
// This can help visually condense modules with large instantiations, 
// but can also lead to confusing code if used too commonly
control cpu_control (
    .*
);
// decoder ir_decoder(
    
// );
alu cpu_alu(


    .alu_out (gate_alu)
);

//16 bits 2:1 muxes
mux_2_1 mio_mux(
    .select   (mem_mem_ena), 
    
    .input1   (bus),
    .input2   (cpu_rdata),
    
     .mux_2_1_out  (mdr_in)
    
);
mux_2_1 sr2_mux(
    .select (),

    .input1    (sr2_mux_in),
    .input2    (),

    .mux_2_1_out (alu_b_in)
    );
mux_2_1 addr1_mux( 
    .select (),

    .input1    (gate_pc),
    .input2    (alu_a_in),

    .mux_2_1_out (adder_b_in)
);

//3 bit2 2:1 muxes
bit3_mux_2_1 dr_mux(
    .select (),
    
    .input1 (),
    .input2 (),

    .mux_2_1_out (dr_in)
);
bit3_mux_2_1 sr1_mux(
     .select (),
    
    .input1 (),
    .input2 (),

    .mux_2_1_out (sr1_in)  
);

//adder2 mux
mux_4_1 adder2_mux(
    .adder2_select (),

    .sext1  (),
    .sext2  (),
    .sext3  (),
    .zero_input (16'b0000000000000000),

    .adder2_mux_out (adder_a_in)
); 

//pc mux
pcmux pcmux_unit(
    .pc_select (pcmux),
    
    .bus_data  (bus),
    .adder     (16'b0000000000000000),
    .pc_plus_one (pc_1),
    
    .pcmux_out   (pc_in)
);  

//bus mux
data_bus bus_mux(
     .databus_select (),
    
    .gateMDR (gate_mdr),
    .gateMARMUX (gate_marmux),
    .gatePC (gate_pc),
    .gateALU (gate_alu),
    
    .databus_out (bus)   
);
    
//general purpose register
reg_file gp_reg (
    .dr   (dr_in),
    .sr2  (sr2_in),
    .sr1  (sr1_in),
    .bus_data (bus),
    .ld_reg (),
    .sr2_out (sr2_mux_in),
    .sr1_out (alu_a_in),
);
    
//fetch registers
load_reg #(.DATA_WIDTH(16)) ir_reg (
    .clk    (clk),
    .reset  (reset),

    .load   (ld_ir),
    .data_i (bus),

    .data_q (ir)
);
load_reg #(.DATA_WIDTH(16)) pc_reg (
    .clk(clk),
    .reset(reset),

    .load(ld_pc),
    .data_i(pc_in),

    .data_q(gate_pc)
);
load_reg #(.DATA_WIDTH(16)) mar_reg (
    .clk(clk),
    .reset(reset),

    .load(ld_mar),
    .data_i(bus),

    .data_q(mar)
);
load_reg #(.DATA_WIDTH(16)) mdr_reg (
    .clk(clk),
    .reset(reset),

    .load(ld_mdr),
    .data_i(mdr_in),

    .data_q(gate_mdr)
);

//status registers
load_reg #(.DATA_WIDTH(1)) n_reg (
    .clk(clk),
    .reset(reset),

    .load(),
    .data_i(),

    .data_q(n)
);
load_reg #(.DATA_WIDTH(1)) z_reg (
    .clk(clk),
    .reset(reset),

    .load(),
    .data_i(),

    .data_q(z)
);
load_reg #(.DATA_WIDTH(1)) p_reg (
    .clk(clk),
    .reset(reset),

    .load(),
    .data_i(),

    .data_q(p)
);

endmodule
