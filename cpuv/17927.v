module, but tmp[smaller:bigger] here.
   logic [WIDTH-1:0] tmp[OFFSET:DEPTH+OFFSET] ;
   generate
      for(genvar i = 0; i < DEPTH; ++i) begin
         always_comb
           if (shift[i]) begin
              tmp[i+1+OFFSET] = {tmp[i+OFFSET][(1 << i)-1:0], tmp[i+OFFSET][WIDTH-1:(2**i)]};
           end
           else begin
              tmp[i+1+OFFSET] = tmp[i+OFFSET];
           end
      end
   endgenerate
   assign tmp[0+OFFSET] = in;
   assign out = tmp[DEPTH+OFFSET];
endmodule