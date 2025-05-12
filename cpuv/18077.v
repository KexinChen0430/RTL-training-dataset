module delay (input wire clk); 
logic unpack_sig0 [10:16] ; 
logic unpack_sig1 [13:16] ; 
logic unpack_sig2 [16:10] ; 
logic unpack_sig3 [16:13] ; 
always @(posedge clk) begin
   if (c <= 5) begin 
      unpack_sig0[13] <= 1'b1; 
      unpack_sig1[13] <= 1'b1; 
      unpack_sig0 [13+1:16] <= unpack_sig0[13:16-1]; 
      unpack_sig1 [13+1:16] <= unpack_sig1[13:16-1]; 
      unpack_sig2[13] <= 1'b1; 
      unpack_sig3[13] <= 1'b1; 
      unpack_sig2 [16:13+1] <= unpack_sig2[16-1:13]; 
      unpack_sig3 [16:13+1] <= unpack_sig3[16-1:13]; 
   end
end
int c = 0; 
always @(posedge clk) begin
   c <= c + 1; 
   if (c >= 4) begin 
      if (!unpack_sig0[16] || !unpack_sig1[16]) $stop;
      if (!unpack_sig2[16] || !unpack_sig3[16]) $stop;
   end else begin 
      if (unpack_sig0[16] || unpack_sig1[16]) $stop;
      if (unpack_sig2[16] || unpack_sig3[16]) $stop;
   end
end
endmodule 