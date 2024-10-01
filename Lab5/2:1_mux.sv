module mux_2_1 (input logic mio_en
                input logic [15:0] bus_data, rdata
                output logic [15:0] mux_out
);

always_comb
  begin
    if(mio_en == 1)
        mux_out = rdata;
    else
        mux_out = bus_data;
  end
endmodule
