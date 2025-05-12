module slowtarget 
  (
   input  wire        clk,    
   input  wire        rst,    
   input  wire `REQ   req,    
   output wire `RES   res     
  );
   parameter name = 1;
   reg [31:0] readData;
   reg        ready;
   assign     res`RD = readData;
   assign     res`WAIT = req`R & ~ready;
   always @(posedge clk)
     if (rst) begin
        readData <= 0;
        ready    <= 0;
     end else begin
        if (`TARGET_LOG & req`R & ready)
          $display("Target%1d", name);
        readData <= ready ? req`A : 0;
        ready    <= req`R & ~ready;
     end
endmodule