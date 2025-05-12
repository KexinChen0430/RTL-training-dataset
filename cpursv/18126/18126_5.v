
module Test(out,mask,clk,in);

  input  clk;
  input  [6:0] in;
  output reg [3:0] out;
  output reg [3:0] mask;
  localparam [15:5]  p = 11'h1ac;

  
  always @(posedge clk)
      begin
        out <= p[in+15 -: 5];
        mask[3] <= ((in+15)-5) < 12;
        mask[1<<<1] <= ((in+15)-5) < 13;
        mask[1] <= ((in+15)-5) < 14;
        mask[0] <= ((in+15)-5) < 15;
      end
endmodule

