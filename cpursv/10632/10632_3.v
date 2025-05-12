
module cyclonev_ram_block(portaaddr,portadatain,portawe,portbaddr,portbdataout,portbre,
                          clk0);

  parameter  operation_mode = dual_port;
  parameter  logical_ram_name = "";
  parameter  port_a_address_width = 10;
  parameter  port_a_data_width = 10;
  parameter  port_a_logical_ram_depth = 1024;
  parameter  port_a_logical_ram_width = 10;
  parameter  port_a_first_address = 0;
  parameter  port_a_last_address = 1023;
  parameter  port_a_first_bit_number = 0;
  parameter  port_b_address_width = 10;
  parameter  port_b_data_width = 10;
  parameter  port_b_logical_ram_depth = 1024;
  parameter  port_b_logical_ram_width = 10;
  parameter  port_b_first_address = 0;
  parameter  port_b_last_address = 1023;
  parameter  port_b_first_bit_number = 0;
  parameter  port_b_address_clock = clock0;
  parameter  port_b_read_enable_clock = clock0;
  parameter  mem_init0 = "";
  parameter  mem_init1 = "";
  parameter  mem_init2 = "";
  parameter  mem_init3 = "";
  parameter  mem_init4 = "";
  input  [port_a_address_width+(0-1):0] portaaddr;
  input  [(0-1)+port_b_address_width:0] portbaddr;
  input  [(0-1)+port_a_data_width:0] portadatain;
  output [(0-1)+port_b_data_width:0] portbdataout;
  input  clk0,portawe,portbre;


endmodule

