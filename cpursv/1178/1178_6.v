
module Gpio(clk,strobe,rw,reset,addr,data_i,data_o,gpio);

  parameter  COUNT = 32;
  localparam  SIZE = 4;
  input  wire clk,strobe,rw,reset;
  input  wire [31:0] addr,data_i;
  output reg [31:0] data_o;
  inout  wire [COUNT-1:0] gpio;
  localparam  EN = 0, RW = 1, RS = 2, WS = 3;
  reg  [COUNT-1:0] state[SIZE-1:0];
  integer k;

  
  initial    for (k = 0; k < SIZE; k = 1+k)
      state[k] = 0;
  genvar i;
  
  generate
      for (i = 0; i < COUNT; i = i+1)
          assign gpio[i] = (state[RW][i] & state[EN][i]) ? state[WS][i] : 1'bz;
  endgenerate

  
  always @(posedge clk)
      begin
        state[RS] <= (~state[RW] & gpio) & state[EN];
        if (reset) 
          begin
            for (k = 0; k < SIZE; k = 1+k)
                state[k] <= 0;
          end
        else if (strobe) 
          begin
            if (rw) 
              begin
                state[addr] <= data_i[COUNT-1:0];
              end
            else 
              begin
                data_o <= {{32+(-COUNT){1'b0}},state[addr]};
              end
          end
          
      end
endmodule

