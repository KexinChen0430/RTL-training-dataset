
module data_ram(data_out,clk,address,data_in,write);

  parameter  DATA_WIDTH = 8;
  parameter  ADDR_WIDTH = 15;
  parameter  INIT_RAM = 1;
  output [(-1)+DATA_WIDTH:0] data_out;
  input  clk;
  input  [ADDR_WIDTH-1:0] address;
  input  [(-1)+DATA_WIDTH:0] data_in;
  input  write;
  reg  [(-1)+DATA_WIDTH:0] data[0:(1<<<1**ADDR_WIDTH)-1];
  reg  [(-1)+DATA_WIDTH:0] output_buffer;

  assign data_out = output_buffer;
  integer i;

  
  initial  
  begin
    output_buffer = 0;
    if (INIT_RAM) 
      begin
        for (i = 0; i < (1<<<1**ADDR_WIDTH); i = 1+i)
            data[i] = 0;
      end
      
  end
  
  always @(posedge clk)
      begin
        if (write) 
          begin
            data[address] <= data_in;
            output_buffer <= data_in;
          end
        else 
          begin
            output_buffer <= data[address];
          end
      end
endmodule

