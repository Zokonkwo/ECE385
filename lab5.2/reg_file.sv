module reg_file(input logic [2:0] dr, sr1, sr2,
                input logic [15:0] bus_data,
                input logic ld_reg,
                output logic [15:0] sr2_out,
                output logic [15:0] sr1_out,);

logic load1, load2, load3, load4, load5, load6, load7, load8;
logic [15:0] gp1_out, gp2_out, gp3_out, gp4_out, gp5_out, gp6_out, gp7_out, gp8_out;

  always_comb
    begin
      if(dr == 3'b000 && ld_reg == 1'b1)
        load1 = 1'b1;
      else if(dr == 3'b001 && ld_reg == 1'b1)
        load2 = 1'b1;
      else if(dr == 3'010 && ld_reg == 1'b1)
        load3 = 1'b1;
      else if(dr == 3'011 && ld_reg == 1'b1)
        load4 = 1'b1;
      else if(dr == 3'100 && ld_reg == 1'b1)
        load5 = 1'b1;
      else if(dr == 3'101 && ld_reg == 1'b1)
        load6 = 1'b1;
      else if(dr == 3'110 && ld_reg == 1'b1)
        load7 = 1'b1;
      else if(dr == 3'b111 && ld_reg == 1'b1)
        load8 = 1'b1;
    end




  
// //general purpose registers
load_reg #(.DATA_WIDTH(16)) gp1_reg (
    .clk(clk),
    .reset(reset),

    .load(load1),
    .data_i(bus_data),

    .data_q()
);
load_reg #(.DATA_WIDTH(16)) gp2_reg (
    .clk(clk),
    .reset(reset),

    .load(load2),
    .data_i(bus_data),

    .data_q()
);
load_reg #(.DATA_WIDTH(16)) gp3_reg (
    .clk(clk),
    .reset(reset),

    .load(load3),
    .data_i(bus_data),

    .data_q()
);
load_reg #(.DATA_WIDTH(16)) gp4_reg (
    .clk(clk),
    .reset(reset),

    .load(load4),
    .data_i(bus_data),

    .data_q()
);
load_reg #(.DATA_WIDTH(16)) gp5_reg (
    .clk(clk),
    .reset(reset),

    .load(load5),
    .data_i(bus_data),

    .data_q()
);
load_reg #(.DATA_WIDTH(16)) gp6_reg (
    .clk(clk),
    .reset(reset),

    .load(load6),
    .data_i(bus_data),

    .data_q()
);
load_reg #(.DATA_WIDTH(16)) gp7_reg (
    .clk(clk),
    .reset(reset),

    .load(load7),
    .data_i(bus_data),

    .data_q()
);
load_reg #(.DATA_WIDTH(16)) gp8_reg (
    .clk(clk),
    .reset(reset),

    .load(load8),
    .data_i(bus_data),

    .data_q()
);


  
endmodule
