module mux_2_1 (input logic mio_en
                input logic [15:0] bus_data, mar_in
                output logic [15:0] rdata
);

always_comb
  begin
    if(mio_en == 1)
        rdata = mar_in;
    else
        rdata = bus_data;
  end
endmodule
