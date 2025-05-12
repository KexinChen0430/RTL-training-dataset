
module dly_signal  #(parameter  WIDTH = 1)
  (input  wire clk,
   input  wire [(0-1)+WIDTH:0] indata,
   output reg [(0-1)+WIDTH:0] outdata);

  
  always @(posedge clk)  outdata <= indata;
endmodule

