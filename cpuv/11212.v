module to_apply_values_to_the_inputs_and
   input [106:0]    in;
   output [7:0]     out1, out2;
   wire [7:0] 	    out1 = (in >>> 99) & 255;
   wire [7:0] 	    out2 = in[106:99];
endmodule