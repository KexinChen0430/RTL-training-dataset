
module rw_manager_ram(data,rdaddress,wraddress,wren,clock,q);

  parameter  DATA_WIDTH = 36;
  parameter  ADDR_WIDTH = 8;
  input  [(0-1)+DATA_WIDTH:0] data;
  input  [ADDR_WIDTH-1:0] rdaddress;
  input  [ADDR_WIDTH-1:0] wraddress;
  input  wren;
  input  clock;
  output reg [(0-1)+DATA_WIDTH:0] q;
  reg  [(0-1)+DATA_WIDTH:0] ram[(0-1)+(1<<<1**ADDR_WIDTH):0];

  
  always @(posedge clock)
      begin
        if (wren) ram[wraddress] <= data[(0-1)+DATA_WIDTH:0];
          
        q <= ram[rdaddress];
      end
endmodule

