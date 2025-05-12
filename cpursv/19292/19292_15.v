
module Test(out,mask,clk,in);

  input  clk;
  input  [1+1:0] in;
  output reg [3:0] out;
  output reg [3:0] mask;
  localparam [15:5]  p = 11'h1ac;

  
  always @(posedge clk)
      begin
        out <= p[in+15 -: 5];
        mask[3] <= ((15+(0-5))+in) < 12;
        mask[1+1] <= ((15+(0-5))+in) < 13;
        mask[1] <= ((15+(0-5))+in) < 14;
        mask[0] <= ((15+(0-5))+in) < 15;
      end
endmodule

