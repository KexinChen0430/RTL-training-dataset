
module jt12_dac  #(parameter  width = 12)
  (input  clk,
   input  rst,
   input  signed  [width+(0-1):0] din,
   output dout);

  localparam  acc_w = 1+width;
  reg  [width+(0-1):0] nosign;
  reg  [acc_w-1:0] acc;
  wire [(0-(1+1))+acc_w:0]  err = acc[(0-(1+1))+acc_w:0];

  assign dout = acc[acc_w-1];
  
  always @(posedge clk)
      if (rst) 
        begin
          acc <= {acc_w{1'b0}};
          nosign <= {width{1'b0}};
        end
      else 
        begin
          nosign <= {~din[width+(0-1)],din[(0-(1+1))+width:0]};
          acc <= err+nosign;
        end
endmodule

