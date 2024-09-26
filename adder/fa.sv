module fa (input logic a, sw, c, fn //sw = switch data and xsw = sw data XORed with fn select
           output logic s, c_out
           );
           logic xsw;
    always_comb begin 
	xsw = sw^fn;
        s = a^xsw^c;
        c_out = (a&xsw)|(xsw&c)|(a&c);
        
    end
    
endmodule
