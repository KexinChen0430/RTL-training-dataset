
module pulse  #(parameter  dly = 3, len = 2)
  (input  rstn,
   input  clk,
   output reg pulse);

  localparam  width = 1+$clog2(len+dly);
  reg  [width-1:0] cnt;

  
  always @(posedge clk or negedge rstn)
      begin
        if (~rstn) cnt <= 1'b0;
        else if (cnt != (len+dly)) cnt <= cnt+1'b1;
          
      end
  
  always @(posedge clk or negedge rstn)
      begin
        if (~rstn) pulse <= 1'b0;
        else if (cnt == dly) pulse <= 1'b1;
        else if (cnt == (len+dly)) pulse <= 1'b0;
          
      end
endmodule

