
module dpram_simple(clock,address_a,wrdata_a,wren_a,rddata_a,address_b,wrdata_b,
                    wren_b,rddata_b);

  parameter  DATA_WIDTH = 8;
  parameter  ADDR_WIDTH = 7;
  parameter  INIT_FILE = somefile;
  parameter  DEBUG = 0;
  input  clock;
  input  [ADDR_WIDTH+(0-1):0] address_a;
  input  [(0-1)+DATA_WIDTH:0] wrdata_a;
  input  wren_a;
  output reg [(0-1)+DATA_WIDTH:0] rddata_a;
  input  [ADDR_WIDTH+(0-1):0] address_b;
  input  [(0-1)+DATA_WIDTH:0] wrdata_b;
  input  wren_b;
  output reg [(0-1)+DATA_WIDTH:0] rddata_b;
  reg  [(0-1)+DATA_WIDTH:0] ram[(0-1)+(1<<<1**ADDR_WIDTH):0];

  
  always @(posedge clock)
      begin
        if (wren_a) ram[address_a] <= wrdata_a;
          
        rddata_a <= ram[address_a];
      end
  
  always @(posedge clock)
      begin
        if (wren_b) ram[address_b] <= wrdata_b;
          
        rddata_b <= ram[address_b];
      end
endmodule

