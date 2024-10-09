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
    input   logic [15:0] cpu_rdata,//added
    output  logic [15:0] hex_display_debug,
    output  logic [15:0] led_o,

    input   logic [15:0] mem_rdata,
    output  logic [15:0] mem_wdata,
    output  logic [15:0] mem_addr,
    output  logic        mem_mem_ena,
    output  logic        mem_wr_ena
);


// Internal connections, follow the datapath block diagram and add the additional needed signals
logic ld_mar, d_mdr, ld_ir, ld_pc, ld_led, ld_cc, ld_reg, ld_ben; 
logic gate_pc, gate_mdr, gate_alu, gate_marmux;

logic [15:0] mar, mdr_in, mdr;   
logic [15:0] pc, pc_in, pc_1;
logic [1:0] pcmux, addr2_mux_select; 
    
logic [15:0] ir; 
logic [15:0] rdata;
logic [15:0] bus;
    
logic [15:0] sr2_mux_in1, sr2_mux_in2, alu_a_in, alu_b_in, adder_a_in, adder_b_in, sext1_in, sext2_in, sext3_in, sext4_in;
logic [2:0] sr1_in, sr2_in, dr_in;
logic [1:0] aluk_in;
    
logic n, z, p, n_in, z_in, p_in;
    
logic dr_select, sr1_select, sr2_mux_select, addr1_mux_select; 
logic [3:0] data_select; 
    
logic ben;

assign sr2_in = ir[2:0];

assign pc_1 = pc + 1; 

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

alu cpu_alu(
    .aluk      (aluk_in),
    .sr2mux     (alu_b_in),
    .sr1out     (alu_a_in),
    .alu_out    (gate_alu)
);
//adder
adder adder_unit(
    .a          (adder_a_in),
    .b          (adder_b_in),

    .adder_out  (gate_marmux)
);
//logic
logic logic_unit(
    .bus_data (bus)
    .n      (n_in),
    .z      (z_in),
    .p      (p_in)
);
//sign extension
sext #(.IN_WIDTH(11), .OUT_WIDTH(16)) sext3(
    .in             (ir[10:0]),
    .out           (sext3_in)
);
sext #(.IN_WIDTH(9), .OUT_WIDTH(16)) sext2(
    .in             (ir[8:0]),
    .out           (sext2_in)
);
sext #(.IN_WIDTH(6), .OUT_WIDTH(16)) sext1(
    .in             (ir[5:0]),
    .out           (sext1_in)
);
sext #(.IN_WIDTH(5), .OUT_WIDTH(16)) sext4(
    .in             (ir[4:0]),
    .out           (sr2_mux_in2)
);
assign led_o = ir;
assign hex_display_debug = ir;

//16 bits 2:1 muxes
mux_2_1 mio_mux(
    .select         (mem_mem_ena), 

    .input1         (bus),
    .input2         (cpu_rdata), 

    .mux_2_1_out    (mdr_in)  
);
mux_2_1 sr2_mux(
    .select         (sr2_mux_select),
    
    .input1         (sr2_mux_in1),
    .input2         (sr2_mux_in2),
    
    .mux_2_1_out    (alu_b_in)
);
mux_2_1 addr1_mux( 
    .select         (addr1_mux_select),
    
    .input1         (gate_pc),
    .input2         (alu_a_in),
    
    .mux_2_1_out    (adder_b_in)
);
//3 bit2 2:1 muxes
bit3_mux_2_1 dr_mux(
    .select         (dr_select),

    .input1         (ir[11:9]),
    .input2         (3'b111),
    
    .mux_2_1_out    (dr_in)
);
bit3_mux_2_1 sr1_mux(
     .select        (sr1_select),

    .input1         (ir[11:9]),
    .input2         (ir[8:6]),
    
    .mux_2_1_out    (sr1_in)  
);
//adder2 mux
mux_4_1 adder2_mux(
    .adder2_select  (addr2_mux_select),
    .sext1          (sext1_in),
    .sext2          (sext2_in),
    .sext3          (sext2_in),
    .zero_input     (16'b0000000000000000),
    .adder2_mux_out (adder_a_in)
); 
//pc mux
// );
pcmux pcmux_unit(
    .pc_select      (pcmux),
    
    .bus_data       (bus),
    .adder          (gate_marmux),
    .pc_plus_one    (pc_1),
    
    .pcmux_out      (pc_in)
);  
//bus mux
data_bus bus_mux(
     .databus_select (data_select),
   
    .gateMDR    (gate_mdr),
    .gateMARMUX (gate_marmux),
    .gatePC     (gate_pc),
    .gateALU    (gate_alu),
    .default_x  (x),
    
    .databus_out (bus)   
);
    
//general purpose register
reg_file gp_reg (
    .dr         (dr_in),
    .sr2        (sr2_in),
    .sr1        (sr1_in),
    .bus_data   (bus),
    .ld_reg     (ld_reg),
    .sr2_out    (sr2_mux_in1),
    .sr1_out    (alu_a_in),
);
    
//fetch registers
load_reg #(.DATA_WIDTH(16)) ir_reg (
    .clk        (clk),
    .reset      (reset),
    .load       (ld_ir),
    .data_i     (bus),
    .data_q     (ir)
);
load_reg #(.DATA_WIDTH(16)) pc_reg (
    .clk        (clk),
    .reset      (reset),
    .load       (ld_pc),
    .data_i     (pc_in),
    .data_q     (gate_pc)
);
load_reg #(.DATA_WIDTH(16)) mar_reg (
    .clk        (clk),
    .reset      (reset),
    .load       (ld_mar),
    .data_i     (bus),
    .data_q     (mar)
);
load_reg #(.DATA_WIDTH(16)) mdr_reg (
    .clk        (clk),
    .reset      (reset),
    .load       (ld_mdr),
    .data_i     (mdr_in),
    .data_q     (gate_mdr)
);

//branch enable
load_reg #(.DATA_WIDTH(1)) ben_reg (
    .clk        (clk),
    .reset      (reset),
    .load       (ld_ben),
    .data_i     ((n & ir[11]) | (z & ir[10]) | (p & ir[15:12])),
    .data_q     (ben)
);

//status registers
load_reg #(.DATA_WIDTH(1)) n_reg (
    .clk        (clk),
    .reset      (reset),
    .load       (ld_cc),
    .data_i     (n_in),
    .data_q     (n)
);
load_reg #(.DATA_WIDTH(1)) z_reg (
    .clk        (clk),
    .reset      (reset),
    .load       (ld_cc),
    .data_i     (z_in),
    .data_q     (z) 
);
load_reg #(.DATA_WIDTH(1)) p_reg (
    .clk        (clk),
    .reset      (reset),
    .load       (ld_cc),
    .data_i     (p_in),
    .data_q     (p)
);

endmodule
