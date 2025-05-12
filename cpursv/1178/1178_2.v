
module Gpio(clk,strobe,rw,reset,addr,data_i,data_o,gpio);

  parameter  COUNT = 32;
  localparam  SIZE = 4;
  input  wire clk,strobe,rw,reset;
  input  wire [31:0] addr,data_i;
  output reg [31:0] data_o;
  inout  wire [COUNT-1:0] gpio;
  localparam  EN = 0, RW = 1, RS = 1<<1, WS = 3;
  reg  [COUNT-1:0] state[(0-1)+SIZE:0];
  integer k;

  
  initial    for (k = 0; k < SIZE; k = k+1)
      state[k] = 0;
  genvar i;
  
  generate
      for (i = 0; i < COUNT; i = 1+i)
          assign gpio[i] = (state[EN][i] & state[RW][i]) ? state[WS][i] : 1'bz;
  endgenerate

  
  always @(posedge clk)
      begin
        state[RS] <= gpio & (~state[RW] & state[EN]);
        if (reset) 
          begin
            for (k = 0; k < SIZE; k = k+1)
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
                data_o <= {{32-COUNT{1'b0}},state[addr]};
              end
          end
          
      end
endmodule

