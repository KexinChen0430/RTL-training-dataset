module CRC_Component (clk,
                      reset,
                      address,
                      writedata,
                      byteenable,
                      write,
                      read,
                      chipselect,
                      readdata);
  parameter crc_width = 32;
  parameter polynomial_inital = 32'hFFFFFFFF;
  parameter polynomial = 32'h04C11DB7;
  parameter reflected_input = 1;
  parameter reflected_output = 1;
  parameter xor_output = 32'hFFFFFFFF;
  input clk;
  input reset;
  input [2:0] address;
  input [31:0] writedata;
  input [3:0] byteenable;
  input write;
  input read;
  input chipselect;
  output [31:0] readdata;
  reg [crc_width-1:0] crc_value;
  wire [crc_width-1:0] poly = polynomial;
  wire [crc_width-1:0] cascade [3:0];
  wire [7:0] block0_data, block1_data, block2_data, block3_data;
  wire [crc_width-1:0] result, result_xored;
  wire [31:0] mux_result;
  reg [31:0] readdata;
  genvar index;
  generate if (reflected_input == 1)
  begin
    for(index = 0; index < 8; index = index + 1)
    begin: input_reflection
      assign block0_data[index] = writedata[7-index];
      assign block1_data[index] = writedata[15-index];
      assign block2_data[index] = writedata[23-index];
      assign block3_data[index] = writedata[31-index];
    end
  end
  else
  begin
    assign block0_data = writedata[7:0];
    assign block1_data = writedata[15:8];
    assign block2_data = writedata[23:16];
    assign block3_data = writedata[31:24];
  end
  endgenerate
  always @ (posedge clk or posedge reset)
  begin
    if(reset == 1)
    begin
      crc_value <= 0;
    end
    else
    begin
      if(write && chipselect && (address == 3'b000))
      begin
        crc_value <= polynomial_inital;  
      end
      else if(write && chipselect && (address == 3'b001))
      begin
		if(byteenable == 4'b0001) 
        begin
          crc_value <= cascade[0];
        end
        else if(byteenable == 4'b0011) 
        begin
          crc_value <= cascade[1];
        end
        else if(byteenable == 4'b0111) 
        begin
          crc_value <= cascade[2];
        end
        else if(byteenable == 4'b1111) 
        begin
          crc_value <= cascade[3];
        end
      end
    end
  end
  XOR_Shift_Block cascade_block0(.block_input(crc_value), .poly(poly), .data_input(block0_data), .block_output(cascade[0]));
    defparam cascade_block0.crc_width = crc_width;
  XOR_Shift_Block cascade_block1(.block_input(cascade[0]), .poly(poly), .data_input(block1_data), .block_output(cascade[1]));
    defparam cascade_block1.crc_width = crc_width;
  XOR_Shift_Block cascade_block2(.block_input(cascade[1]), .poly(poly), .data_input(block2_data), .block_output(cascade[2]));
    defparam cascade_block2.crc_width = crc_width;
  XOR_Shift_Block cascade_block3(.block_input(cascade[2]), .poly(poly), .data_input(block3_data), .block_output(cascade[3]));
    defparam cascade_block3.crc_width = crc_width;
  generate if (reflected_output == 1)
  begin
    for(index = 0; index < crc_width; index = index + 1)
    begin: output_reflection32
      assign result[index] = crc_value[(crc_width-1)-index];
    end
  end
  else
  begin
    assign result = crc_value;
  end
  endgenerate
  assign result_xored = result ^ xor_output;
  generate if((crc_width > 32) && (crc_width < 65))
  begin
    assign mux_result = (address == 3'b100)? result_xored[31:0] : result_xored[crc_width-1:32];
  end
  else if((crc_width > 64) && (crc_width < 97))
  begin
    assign mux_result = (address == 3'b100)? result_xored[31:0] :
                     ((address == 3'b101)? result_xored[63:32] : result_xored[crc_width-1:64]);
  end
  else if((crc_width > 96) && (crc_width < 129))
  begin
    assign mux_result = (address == 3'b100)? result_xored[31:0] :
                     ((address == 3'b101)? result_xored[63:32] :
                     ((address == 3'b110)? result_xored[95:64] : result_xored[crc_width-1:96]));
  end
  else
  begin
    assign mux_result = result_xored;
  end
  endgenerate
  always @ (posedge clk or posedge reset)
  begin
    if(reset == 1)
    begin
      readdata <= 0;
    end
    else if((read == 1) && (chipselect == 1))
    begin
      readdata <= mux_result;
    end
  end
endmodule