module adder (input logic [15:0] a, b
              output logic [15:0] adder_out);

    always_comb
        begin
            adder_out = a + b;
        end
endmodule