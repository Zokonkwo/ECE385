module logic (input logic [15:0] bus_data, 
              output logic n, z, p);

    always_comb
        begin
            if(bus_data == 16'b0000000000000000)
                begin 
                    n = 0;
                    z = 1;
                    p = 0;
                end
            else if(bus_data[15] == 1'b1)
                begin 
                    n = 1;
                    z = 0;
                    p = 0;
                end
          else if(bus_data[15] == 1'b0)
                begin 
                    n = 0;
                    z = 0;
                    p = 1;
                end
          else
              begin
                    n = x;
                    z = x;
                    p = x;
              end
        end
    end

endmodule
