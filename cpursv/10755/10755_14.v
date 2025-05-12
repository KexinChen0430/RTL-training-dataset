
module pipeline_stall  #(parameter  WIDTH = 1, DELAY = 1)
  (input  wire clk,
   input  wire reset,
   input  wire [(-1)+WIDTH:0] datain,
   output wire [(-1)+WIDTH:0] dataout);

  reg  [(DELAY*WIDTH)-1:0]  dly_datain = 0;

  assign dataout = dly_datain[(DELAY*WIDTH)-1:(DELAY+(-1))*WIDTH];
  
  always @(posedge clk or posedge reset)
      if (reset) dly_datain <= 0;
      else dly_datain <= {dly_datain,datain};
endmodule

