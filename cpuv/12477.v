module Test 
  (
   input              clk, 
   input [63:0]       crc, 
   input [31:0]       cyc, 
   output wire [31:0] result); 
   wire         enable = crc[32]; 
   wire [31:0]  d = crc[31:0]; 
   logic [31:0] y; 
   always @(d iff enable == 1) begin 
      y <= d; 
   end
   wire reset = (cyc < 10); 
   assert property (@(posedge clk iff enable) 
                    disable iff (reset) 
                    (crc != '0)); 
   assign result = {32'h0, y}; 
endmodule 