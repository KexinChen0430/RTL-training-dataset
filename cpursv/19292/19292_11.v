
module Test(out,mask,clk,in);

  input  clk;
  input  [1<<1:0] in;
  output reg [3:0] out;
  output reg [3:0] mask;
  localparam [15:5]  p = 11'h1ac;

  
  always @(posedge clk)
      begin
        out <= p[15+in -: 5];
        mask[3] <= ((in+(0-5))+15) < 12;
        mask[1<<1] <= ((in+(0-5))+15) < 13;
        mask[1] <= ((in+(0-5))+15) < 14;
        mask[0] <= ((in+(0-5))+15) < 15;
      end
endmodule

