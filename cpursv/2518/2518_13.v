
module pulse  #(parameter  dly = 3, len = 1<<1)
  (input  rstn,
   input  clk,
   output reg pulse);

  localparam  width = $clog2(len+dly)+1;
  reg  [width-1:0] cnt;

  
  always @(posedge clk or negedge rstn)
      begin
        if (~rstn) cnt <= 1'b0;
        else if (cnt != (len+dly)) cnt <= 1'b1+cnt;
          
      end
  
  always @(posedge clk or negedge rstn)
      begin
        if (~rstn) pulse <= 1'b0;
        else if (cnt == dly) pulse <= 1'b1;
        else if (cnt == (len+dly)) pulse <= 1'b0;
          
      end
endmodule

