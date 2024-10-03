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
logic gate_alu;
logic gate_marmux;

logic [15:0] mar;
logic [15:0] mdr_in;
logic [15:0] mdr;
    
logic [1:0] pcmux; 
logic [15:0] pc;
logic [15:0] pc_in;
logic [15:0] pc_1;
assign pc_1 = pc + 1;  
    
logic [15:0] ir;
    
logic [15:0] rdata;

logic [15:0] bus;
    
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

//muxes
mux_2_1 mio_mux(
    .select   (mem_mem_ena), 
    
    .input_1 (bus),
    .input_2   (cpu_rdata),
    
     .mux_out  (mdr_in)
    
);
mux_2_1 dr_mux();
mux_2_1 sr1_mux();
mux_2_1 sr2_mux();
mux_2_1 addr1_mux();

pcmux pcmux_unit(
    .pc_select (pcmux),
    .bus_data  (bus),
    .adder     (16'b0000000000000000),
    .pc_plus_one (pc_1),
    .pcmux_out   (pc_in)
);  
data_bus bus_mux(
    .gateMDR (gate_mdr),
    .gateMARMUX (gate_marmux),
    .gatePC (gate_pc),
    .gateALU (gate_alu),
    .databus_select (),
        
    .databus_out (bus)   
);
//general purpose register
reg_file gp_reg (
    .dr   (),
    .sr2  (),
    .sr1  (),
    .bus_data (bus),
    .ld_reg (),
    .sr2_out (),
    .sr1_out (),
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
