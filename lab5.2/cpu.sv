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
logic ld_mar; 
logic ld_mdr; 
logic ld_ir; 
logic ld_pc; 
logic ld_led;

logic gate_pc;
logic gate_mdr;

logic [1:0] pcmux;

logic [15:0] mar;
logic [15:0] mdr_in;
logic [15:0] mdr;
logic [15:0] ir;
logic [15:0] pc;
logic [15:0] pc_in;
logic [15:0] pc_1;
assign pc_1 = pc + 1;
logic [15:0] rdata;
logic ben;


assign mem_addr = mar;
assign mem_wdata = mdr;

// State machine, you need to fill in the code here as well
// .* auto-infers module input/output connections which have the same name
// This can help visually condense modules with large instantiations, 
// but can also lead to confusing code if used too commonly
control cpu_control (
    .*
);


assign led_o = ir;
assign hex_display_debug = ir;

    
// mux_2_1 mux(
//     .mio_en   (mem_mem_ena), 
    
//     .bus_data (),
//     .rdata   (cpu_rdata),
    
//      .mux_out  (mdr_in)
    
// );
pcmux pcmux_unit(
    .pc_select (pcmux),
    .bus_data  (16'b0000000000000000),
    .adder     (16'b0000000000000000),
    .pc_plus_one (pc_1),
    .pcmux_out   (pc_in)
    );
    
load_reg #(.DATA_WIDTH(16)) ir_reg (
    .clk    (clk),
    .reset  (reset),

    .load   (ld_ir),
    .data_i (mdr),

    .data_q (ir)
);

load_reg #(.DATA_WIDTH(16)) pc_reg (
    .clk(clk),
    .reset(reset),

    .load(ld_pc),
    .data_i(pc_in),

    .data_q(pc)
);
    load_reg #(.DATA_WIDTH(16)) mar_reg (
    .clk(clk),
    .reset(reset),

    .load(ld_mar),
    .data_i(pc),

    .data_q(mar)
);
    load_reg #(.DATA_WIDTH(16)) mdr_reg (
    .clk(clk),
    .reset(reset),

    .load(ld_mdr),
    .data_i(cpu_rdata),

    .data_q(mdr)
);
    load_reg#(.DATA_WIDTH(16)) nzp (
        .clk (clk)
        .reset (reset)
        .load (),
        .data_i (),
        .data_q ()
    );



endmodule
