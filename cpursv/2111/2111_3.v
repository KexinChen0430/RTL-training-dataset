
module jt12_dac  #(parameter  width = 12)
  (input  clk,
   input  rst,
   input  signed  [width-1:0] din,
   output dout);

  localparam  acc_w = width+1;
  reg  [width-1:0] nosign;
  reg  [(0-1)+acc_w:0] acc;
  wire [acc_w+(-1<<<1):0]  err = acc[acc_w+(-1<<<1):0];

  assign dout = acc[(0-1)+acc_w];
  
  always @(posedge clk)
      if (rst) 
        begin
          acc <= {acc_w{1'b0}};
          nosign <= {width{1'b0}};
        end
      else 
        begin
          nosign <= {~din[width-1],din[width-1<<<1:0]};
          acc <= err+nosign;
        end
endmodule

