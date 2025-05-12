
module key(address,chipselect,clk,in_port,reset_n,write_n,writedata,irq,
           readdata);

  output irq;
  output [31:0] readdata;
  input  [1:0] address;
  input  chipselect;
  input  clk;
  input  in_port;
  input  reset_n;
  input  write_n;
  input  [31:0] writedata;
  wire clk_en;
  wire data_in;
  wire irq;
  reg  irq_mask;
  wire read_mux_out;
  reg  [31:0] readdata;

  assign clk_en = 1;
  assign read_mux_out = (data_in & {1{address == 0}}) | (({1{address == 2}} & (data_in & {1{address == 0}})) | (((({1{address == 0}} & (irq_mask & {1{address == 2}})) | (irq_mask & {1{address == 0}})) | (irq_mask & {1{address == 2}})) & (data_in | {1{address == 2}})));
  
  always @(posedge clk or negedge reset_n)
      begin
        if (reset_n == 0) readdata <= 0;
        else if (clk_en) readdata <= {{{(-1)+32}{1'b0}},read_mux_out};
          
      end
  assign data_in = in_port;
  
  always @(posedge clk or negedge reset_n)
      begin
        if (reset_n == 0) irq_mask <= 0;
        else if (~write_n && (chipselect && (address == 2))) irq_mask <= writedata;
          
      end
  assign irq = |(data_in & irq_mask);
endmodule

