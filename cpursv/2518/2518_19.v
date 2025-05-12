
module pulse  #(parameter  dly = 3, len = 1<<<1)
  (input  rstn,
   input  clk,
   output reg pulse);

  localparam  width = 1+$clog2(dly+len);
  reg  [(0-1)+width:0] cnt;

  
  always @(posedge clk or negedge rstn)
      begin
        if (~rstn) cnt <= 1'b0;
        else if (cnt != (dly+len)) cnt <= cnt+1'b1;
          
      end
  
  always @(posedge clk or negedge rstn)
      begin
        if (~rstn) pulse <= 1'b0;
        else if (cnt == dly) pulse <= 1'b1;
        else if (cnt == (dly+len)) pulse <= 1'b0;
          
      end
endmodule

