module reg_file(input logic [2:0] dr, sr1, sr2,
                input logic [15:0] bus_data,
                input logic ld_reg,
                output logic [15:0] sr2_out,
                output logic [15:0] sr2_out,);


// //general purpose registers
load_reg #(.DATA_WIDTH(16)) gp1_reg (
    .clk(clk),
    .reset(reset),

    .load(),
  .data_i(bus),

    .data_q()
);
load_reg #(.DATA_WIDTH(16)) gp2_reg (
    .clk(clk),
    .reset(reset),

    .load(),
    .data_i(bus),

    .data_q()
);
load_reg #(.DATA_WIDTH(16)) gp3_reg (
    .clk(clk),
    .reset(reset),

    .load(),
    .data_i(bus),

    .data_q()
);
load_reg #(.DATA_WIDTH(16)) gp4_reg (
    .clk(clk),
    .reset(reset),

    .load(),
    .data_i(bus),

    .data_q()
);
load_reg #(.DATA_WIDTH(16)) gp5_reg (
    .clk(clk),
    .reset(reset),

    .load(),
    .data_i(bus),

    .data_q()
);
load_reg #(.DATA_WIDTH(16)) gp6_reg (
    .clk(clk),
    .reset(reset),

    .load(),
    .data_i(bus),

    .data_q()
);
load_reg #(.DATA_WIDTH(16)) gp7_reg (
    .clk(clk),
    .reset(reset),

    .load(),
    .data_i(bus),

    .data_q()
);
load_reg #(.DATA_WIDTH(16)) gp8_reg (
    .clk(clk),
    .reset(reset),

    .load(),
    .data_i(bus),

    .data_q()
);


  
endmodule
