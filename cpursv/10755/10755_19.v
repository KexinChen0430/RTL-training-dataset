
module pipeline_stall  #(parameter  WIDTH = 1, DELAY = 1)
  (input  wire clk,
   input  wire reset,
   input  wire [WIDTH-1:0] datain,
   output wire [WIDTH-1:0] dataout);

  reg  [(0-1)+(WIDTH*DELAY):0]  dly_datain = 0;

  assign dataout = dly_datain[(0-1)+(WIDTH*DELAY):WIDTH*((0-1)+DELAY)];
  
  always @(posedge clk or posedge reset)
      if (reset) dly_datain <= 0;
      else dly_datain <= {dly_datain,datain};
endmodule

