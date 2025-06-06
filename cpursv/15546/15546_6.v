
module DSpm(input  clk,
            input  [11:0] io_core_addr,
            input  io_core_enable,
            output [31:0] io_core_data_out,
            input  io_core_byte_write_3,
            input  io_core_byte_write_2,
            input  io_core_byte_write_1,
            input  io_core_byte_write_0,
            input  [31:0] io_core_data_in,
            input  [11:0] io_bus_addr,
            input  io_bus_enable,
            output [31:0] io_bus_data_out,
            input  io_bus_byte_write_3,
            input  io_bus_byte_write_2,
            input  io_bus_byte_write_1,
            input  io_bus_byte_write_0,
            input  [31:0] io_bus_data_in);

  wire [7:0] core_byte_write;
  wire [7:0] bus_byte_write;

  assign core_byte_write = {io_core_byte_write_3,io_core_byte_write_3,io_core_byte_write_2,io_core_byte_write_2,io_core_byte_write_1,io_core_byte_write_1,io_core_byte_write_0,io_core_byte_write_0};
  assign bus_byte_write = {io_core_byte_write_3,io_core_byte_write_3,io_core_byte_write_2,io_core_byte_write_2,io_core_byte_write_1,io_core_byte_write_1,io_core_byte_write_0,io_core_byte_write_0};
  genvar i;
  
  generate
      for (i = 0; i < 8; i = i+1)
          begin : BRAMS
            reg  [3:0] dspm[4095:0];

            reg  [3:0] core_data_out,bus_data_out;

            
            always @(posedge clk)
                begin
                  if (io_core_enable) 
                    begin
                      if (core_byte_write[i]) 
                        begin
                          dspm[io_core_addr] <= io_core_data_in[(i*4)+3:i*4];
                        end
                        
                      core_data_out <= dspm[io_core_addr];
                    end
                    
                end
            assign io_core_data_out[(i*4)+3:i*4] = core_data_out;
          end
  endgenerate

endmodule

