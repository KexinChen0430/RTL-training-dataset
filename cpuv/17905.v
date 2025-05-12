module var_decl_with_init();
   logic [-1:30] var0  = {4'd0, 4'd1, 4'd2, 4'd3, 4'd4, 4'd5, 4'd6, 4'd7};
   logic [-1:30] var2 ;
   logic [30:-1] var1  = {4'd0, 4'd1, 4'd2, 4'd3, 4'd4, 4'd5, 4'd6, 4'd7};
   logic [30:-1] var3 ;
   initial begin
      var2[-1:2] = 4'd2;
      var3[2:-1] = 4'd3;
      $display("%x %x", var0, var1);
      $display("%x %x", var2, var3);
      var0[-1:5] = 7'd0;
      var1[10:3] = 8'd2;
   end
endmodule