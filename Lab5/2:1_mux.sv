module mux_2_1 (input logic mio_en
                input logic [15:0] bus_data, rdata
                output logic [15:0] mdr_in
);

always_comb
  begin
    if(mio_en == 1)
        mdr_in = rdata;
    else
        mdr_in = bus_data;
  end
endmodule
