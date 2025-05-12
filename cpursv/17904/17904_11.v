
module altera_onchip_flash_convert_address(address,flash_addr);

  parameter  FLASH_ADDR_WIDTH = 23;
  parameter  ADDR_RANGE1_END_ADDR = 1;
  parameter  ADDR_RANGE1_OFFSET = 1;
  parameter  ADDR_RANGE2_OFFSET = 1;
  input  [(0-1)+FLASH_ADDR_WIDTH:0] address;
  output [(0-1)+FLASH_ADDR_WIDTH:0] flash_addr;

  assign flash_addr = (address <= ADDR_RANGE1_END_ADDR[(0-1)+FLASH_ADDR_WIDTH:0]) ? (address+ADDR_RANGE1_OFFSET[(0-1)+FLASH_ADDR_WIDTH:0]) : (address+ADDR_RANGE2_OFFSET[(0-1)+FLASH_ADDR_WIDTH:0]);
endmodule

