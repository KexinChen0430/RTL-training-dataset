module fasttarget 
  (input  wire        clk,
   input  wire        rst,
   input  wire `REQ   req,
   output reg  `RES   res);
   parameter name = 1;
   always @(posedge clk) begin
      res`WAIT <= 0;
      res`RD <= ~rst && req`R ? req`A : 0;
      if (`TARGET_LOG & req`R)
        $display("Target%1d", name);
   end
endmodule