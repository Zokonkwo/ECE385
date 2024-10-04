module mux_4_1 (input logic [2:0] adder2_select,
                input logic [15:0] sext1, sext2, sext3, zero_input,
                output lofic [15:0] adder2_mux_out);
  always_comb
    begin
      if(adder2_select == 3'b000)
        adder2_mux_out = zero_input;
      else if(adder2_select == 3'b001)
        adder2_mux_out = sext1;
      else if(adder2_select == 3'b010)
        adder2_mux_out = sext2;
      else if (adder2_select == 3'b011)
        adder2_mux_out = sext3;
    end
  end
endmodule
