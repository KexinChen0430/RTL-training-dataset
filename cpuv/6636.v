module baudgen(
  input wire clk,         
  output wire ser_clk     
);
  localparam lim = (`CLKFREQ / `BAUD) - 1; 
  localparam w = $clog2(lim); 
  wire [w-1:0] limit = lim; 
  reg [w-1:0] counter; 
  assign ser_clk = (counter == limit); 
  always @(posedge clk)
    counter <= ser_clk ? 0 : (counter + 1); 
endmodule 