module slowtarget 
  (
   input  wire        clk, 
   input  wire        rst, 
   input  wire `REQ   req, 
   output wire `RES   res  
  );
   reg [31:0] readData;
   reg        ready;
   assign     res`RD = readData;
   assign     res`WAIT = req`R & ~ready;
   always @(posedge clk)
     if (rst) begin
        readData <= 0;
        ready    <= 0;
     end else begin
        readData <= ready ? req`A : 0;
        ready    <= req`R & ~ready;
     end
endmodule