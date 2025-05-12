
module delay51x1(datain,dataout,clk);

  input  [(0-1)+51:0] datain;
  output [(0-1)+51:0] dataout;
  wire [(0-1)+51:0] dataout;
  input  clk;
  reg  [(0-1)+51:0] buff0;

  assign dataout = buff0;
  
  always @(posedge clk)
      begin
        buff0 <= datain;
      end
endmodule

