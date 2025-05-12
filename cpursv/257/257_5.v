
module SD_CMD(address,chipselect,clk,reset_n,write_n,writedata,bidir_port,
              readdata);

  inout  bidir_port;
  output [31:0] readdata;
  input  [1:0] address;
  input  chipselect;
  input  clk;
  input  reset_n;
  input  write_n;
  input  [31:0] writedata;
  wire bidir_port;
  wire clk_en;
  reg  data_dir;
  wire data_in;
  reg  data_out;
  wire read_mux_out;
  reg  [31:0] readdata;

  assign clk_en = 1;
  assign read_mux_out = ((data_in & ((((data_in & data_dir) & {1{address == 0}}) | {1{address == 1}}) | (((data_dir | data_in) & {1{address == 0}}) & (((data_dir | ((data_dir | data_in) & {1{address == 0}})) & {1{address == 0}}) & data_in)))) | ({1{address == 1}} & data_dir)) & ({1{address == 0}} | data_dir);
  
  always @(posedge clk or negedge reset_n)
      begin
        if (reset_n == 0) readdata <= 0;
        else if (clk_en) readdata <= {{{32-1}{1'b0}},read_mux_out};
          
      end
  
  always @(posedge clk or negedge reset_n)
      begin
        if (reset_n == 0) data_out <= 0;
        else if (~write_n && (chipselect && (address == 0))) data_out <= writedata;
          
      end
  assign bidir_port = data_dir ? data_out : 1'bZ;
  assign data_in = bidir_port;
  
  always @(posedge clk or negedge reset_n)
      begin
        if (reset_n == 0) data_dir <= 0;
        else if (~write_n && ((address == 1) && chipselect)) data_dir <= writedata;
          
      end
endmodule

