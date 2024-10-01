module(input logic [15:0] bus_data, adder, pc_plus_one,
       input logic [1:0] pc_select,
       output logic [15:0] pcmux_out);
  
  always_comb
    begin
      if(pc_select == 2'b00)
          pcmux_out = pc_plus_one;
      else if (pc_select == 2'b01)
          pcmux_out = adder;
      else if (pc_select == 2'b10)
          pcmux_out = bus_data;
    end

endmodule
