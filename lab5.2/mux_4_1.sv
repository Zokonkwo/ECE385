module mux_4_1 (input logic [1:0] adder2_select,
                input logic [15:0] sext1, sext2, sext3, zero_input,
                output lofic [15:0] adder2_mux_out);
  always_comb
    begin
      if(adder2_select == 2'b00)
        adder2_mux_out = zero_input;
      else if(adder2_select == 3'b01)
        adder2_mux_out = sext1;
      else if(adder2_select == 3'b10)
        adder2_mux_out = sext2;
      else if (adder2_select == 3'b11)
        adder2_mux_out = sext3;
    end
  end
endmodule
