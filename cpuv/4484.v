module fasttarget 
  (
   input  wire        clk, 
   input  wire        rst, 
   input  wire `REQ   req, 
   output reg  `RES   res  
  );
  always @(posedge clk) begin
      res`WAIT <= 0;
      res`RD <= ~rst && req`R ? req`A : 0;
  end
endmodule