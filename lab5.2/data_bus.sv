module data_bus (input logic [15:0] gateMDR, gateALU, gatePC, gateMARMUX, default_x,
                 input logic [3:0] databus_select,
                 output logic [15:0] databus_out);
    always_comb
        begin
            if(databus_select == 4'b0000)
                databus_out = default_x;
            if(databus_select == 4'b0001)
                databus_out = gateMDR;
            else if(databus_select == 4'b0010)
                databus_out = gateALU;
            else if(databus_select == 4'b0100)
                databus_out = gatePC;
            else if(databus_select == 4'b1000)
                databus_out = gateMARMUX;
            else
                databus_out = default_x;
        end
    end
endmodule
