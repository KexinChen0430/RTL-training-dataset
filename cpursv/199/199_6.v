
module rw_manager_ram(data,rdaddress,wraddress,wren,clock,q);

  parameter  DATA_WIDTH = 36;
  parameter  ADDR_WIDTH = 8;
  input  [DATA_WIDTH-1:0] data;
  input  [(-1)+ADDR_WIDTH:0] rdaddress;
  input  [(-1)+ADDR_WIDTH:0] wraddress;
  input  wren;
  input  clock;
  output reg [DATA_WIDTH-1:0] q;
  reg  [DATA_WIDTH-1:0] ram[(-1)+(1<<<1**ADDR_WIDTH):0];

  
  always @(posedge clock)
      begin
        if (wren) ram[wraddress] <= data[DATA_WIDTH-1:0];
          
        q <= ram[rdaddress];
      end
endmodule

