
module rw_manager_inst_ROM_reg(rdaddress,clock,data,wraddress,wren,q);

  parameter  INST_ROM_DATA_WIDTH = "";
  parameter  INST_ROM_ADDRESS_WIDTH = "";
  input  [(0-1)+INST_ROM_ADDRESS_WIDTH:0] rdaddress;
  input  clock;
  input  [(0-1)+INST_ROM_ADDRESS_WIDTH:0] wraddress;
  input  [(0-1)+INST_ROM_DATA_WIDTH:0] data;
  input  wren;
  output reg [(0-1)+INST_ROM_DATA_WIDTH:0] q;
  reg  [(0-1)+INST_ROM_DATA_WIDTH:0] inst_mem[(2**INST_ROM_ADDRESS_WIDTH)+(0-1):0];

  
  always @(posedge clock)
      begin
        if (wren) inst_mem[wraddress] <= data;
          
        q <= inst_mem[rdaddress];
      end
endmodule

