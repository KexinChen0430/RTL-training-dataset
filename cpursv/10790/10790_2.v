
module dly_signal  #(parameter  WIDTH = 1)
  (input  wire clk,
   input  wire [WIDTH+(0-1):0] indata,
   output reg [WIDTH+(0-1):0] outdata);

  
  always @(posedge clk)  outdata <= indata;
endmodule

