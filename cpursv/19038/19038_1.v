
module delay51x1(datain,dataout,clk);

  input  [(-1)+51:0] datain;
  output [(-1)+51:0] dataout;
  wire [(-1)+51:0] dataout;
  input  clk;
  reg  [(-1)+51:0] buff0;

  assign dataout = buff0;
  
  always @(posedge clk)
      begin
        buff0 <= datain;
      end
endmodule

