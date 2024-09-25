
module fa (input logic a, sw, fn, xsw, c, //sw = switch data and xsw = sw data XORed with fn select
           output logic s, c_out
           );
           
    always_comb begin 
	xsw = sw^fn;
        s = a^xsw^c;
        c_out = (a&xsw)|(xsw&c)|(a&c);
        
    end
    
endmodule
//////////////////////////////////////////////////////
module ripple_adder_9 (input logic [8:0] XA, xsw,
                       input logic  c_in, fn,
		       output logic [8:0] s,
                       output logic c_out);
                       
    logic c1, c2, c3, c4, c5, c6, c7, c8;

	fa fa0 (.a(XA[0]), .xsw(xsw[0]), .c(fn), .s(s[0]), .c_out(c1));
	fa fa1 (.a(XA[1]), .xsw(xsw[1]), .c(c1), .s(s[1]), .c_out(c2));
	fa fa2 (.XA(a[2]), .xsw(xsw[2]), .c(c2), .s(s[2]), .c_out(c3));
	fa fa3 (.XA(a[3]), .xsw(xsw[3]), .c(c3), .s(s[3]), .c_out(c4));
	fa fa4 (.XA(a[4]), .xsw(xsw[4]), .c(c4), .s(s[4]), .c_out(c5));
	fa fa5 (.XA(a[5]), .xsw(xsw[5]), .c(c5), .s(s[5]), .c_out(c6));
	fa fa6 (.XA(a[6]), .xsw(xsw[6]), .c(c6), .s(s[6]), .c_out(c7));
	fa fa7 (.XA(a[7]), .xsw(xsw[7]), .c(c7), .s(s[7]), .c_out(c8));
	fa fa8 (.XA(a[8]), .xsw(xsw[8]), .c(c8), .s(s[8]), .c_out(c_out));
    
endmodule
///////////////////////////////////////////////////////
// module ripple_adder (
// 	input  logic  [8:0] a, xsw,
// 	input  logic  fn,
	
// 	output logic  [8:0] s,
// 	output logic  cout
// );
             
//         logic c3, c6; 
//         ripple_adder_3 ra3_0 (.a(a[2:0]),   .xsw(xsw[2:0]),   .c_in(fn),  .s(s[2:0]),   .c_out(c3) );
//         ripple_adder_3 ra3_1 (.a(a[5:3]),   .xsw(xsw[5:3]),   .c_in(c3),  .s(s[5:3]),   .c_out(c6) );
//         ripple_adder_3 ra3_2 (.a(a[8:6]),   .xsw(xsw[8:6]),   .c_in(c6),  .s(s[8:6]),   .c_out(cout) );
       
// endmodule
