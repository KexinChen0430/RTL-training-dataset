
module data_ram(data_out,clk,address,data_in,write);

  parameter  DATA_WIDTH = 8;
  parameter  ADDR_WIDTH = 15;
  parameter  INIT_RAM = 1;
  output [DATA_WIDTH-1:0] data_out;
  input  clk;
  input  [ADDR_WIDTH-1:0] address;
  input  [DATA_WIDTH-1:0] data_in;
  input  write;
  reg  [DATA_WIDTH-1:0] data[0:1<<<ADDR_WIDTH-1];
  reg  [DATA_WIDTH-1:0] output_buffer;

  assign data_out = output_buffer;
  integer i;

  
  initial  
  begin
    output_buffer = 0;
    if (INIT_RAM) 
      begin
        for (i = 0; i < 1<<<ADDR_WIDTH; i = i+1)
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

