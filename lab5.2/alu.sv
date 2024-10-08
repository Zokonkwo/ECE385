module alu (input logic [15:0] sr2mux, sr1out, 
            input logic [1:0] aluk,
            output logic [15:0] alu_out);


    always_comb
        begin
          if(aluk == 2'b00) //ADD
            alu_out = sr2_mux + sr1_out;
          else if(aluk == 2'b01) //AND
            alu_out = sr2_mux & sr1_out;
          else if (aluk == 2'b10) //PASSA
            alu_out = sr1out;
          else if (aluk == 2'b11) //NOT
            alu_out =  ~(sr1_out);
        end
    end
  
endmodule
