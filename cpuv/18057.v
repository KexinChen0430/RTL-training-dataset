module sub6 #(parameter P0 = 1, parameter P1 = 2) (
    output wire [7:0] out[2]  
); `HIER_BLOCK  
   assign out[0] = 8'(P0);
   assign out[1] = 8'(P1);
endmodule 