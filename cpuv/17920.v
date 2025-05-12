module barshift_1d_unpacked_struct0 #(parameter DEPTH = 2, localparam WIDTH = 2**DEPTH)
   (input [WIDTH-1:0] in, input [DEPTH-1:0] shift, output [WIDTH-1:0] out);
   localparam OFFSET = 1;
   typedef struct packed { logic [WIDTH-1:0] data; } data_type;
   data_type tmp[DEPTH+OFFSET:OFFSET] ;
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