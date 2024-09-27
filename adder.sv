module fa (input logic a, sw, c, fn, //sw = switch data and xsw = sw data XORed with fn select
           output logic s, c_out
           );
           logic xsw;
    always_comb begin 
	xsw = sw^fn;
        s = a^xsw^c;
        c_out = (a&xsw)|(xsw&c)|(a&c);
        
    end
    
endmodule

module ripple_adder_9 (input logic [8:0] XA, sw,
                       input logic  fn,
		       output logic [8:0] s,
                       output logic c_out // c_out is not needed
		      );
                       
    logic c1, c2, c3, c4, c5, c6, c7, c8, c9;

	fa fa0 (.a(XA[0]), .sw(sw[0]), .c(fn), .s(s[0]), .c_out(c1), .fn(fn));
	fa fa1 (.a(XA[1]), .sw(sw[1]), .c(c1), .s(s[1]), .c_out(c2), .fn(fn));
	fa fa2 (.a(XA[2]), .sw(sw[2]), .c(c2), .s(s[2]), .c_out(c3), .fn(fn));
	fa fa3 (.a(XA[3]), .sw(sw[3]), .c(c3), .s(s[3]), .c_out(c4), .fn(fn));
	fa fa4 (.a(XA[4]), .sw(sw[4]), .c(c4), .s(s[4]), .c_out(c5), .fn(fn));
	fa fa5 (.a(XA[5]), .sw(sw[5]), .c(c5), .s(s[5]), .c_out(c6), .fn(fn));
	fa fa6 (.a(XA[6]), .sw(sw[6]), .c(c6), .s(s[6]), .c_out(c7), .fn(fn));
	fa fa7 (.a(XA[7]), .sw(sw[7]), .c(c7), .s(s[7]), .c_out(c8), .fn(fn));
	fa fa8 (.a(XA[7]), .sw(sw[7]), .c(c8), .s(s[8]), .c_out(c9), .fn(fn));
endmodule
