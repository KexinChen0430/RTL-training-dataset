
module cyclonev_mlab_cell(portaaddr,portadatain,portbaddr,portbdataout,ena0,clk0,clk1);

  parameter  logical_ram_name = "";
  parameter  logical_ram_depth = 32;
  parameter  logical_ram_width = 20;
  parameter  mixed_port_feed_through_mode = new;
  parameter  first_bit_number = 0;
  parameter  first_address = 0;
  parameter  last_address = 31;
  parameter  address_width = 5;
  parameter  data_width = 1;
  parameter  byte_enable_mask_width = 1;
  parameter  port_b_data_out_clock = NONE;
  parameter [639:0]  mem_init0 = 640'b0;
  input  [address_width+(-1):0] portaaddr,portbaddr;
  input  [data_width-1:0] portadatain;
  output [data_width-1:0] portbdataout;
  input  ena0,clk0,clk1;


endmodule

