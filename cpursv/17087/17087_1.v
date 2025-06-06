
module Computer_System_VGA_Subsystem_VGA_Pixel_RGB_Resampler(clk,reset,stream_in_data,stream_in_startofpacket,
                                                             stream_in_endofpacket,stream_in_empty,stream_in_valid,
                                                             stream_out_ready,stream_in_ready,stream_out_data,
                                                             stream_out_startofpacket,stream_out_endofpacket,
                                                             stream_out_empty,stream_out_valid);

  parameter  IDW = 15;
  parameter  ODW = 29;
  parameter  IEW = 0;
  parameter  OEW = 1;
  parameter  ALPHA = 10'h3FF;
  input  clk;
  input  reset;
  input  [IDW:0] stream_in_data;
  input  stream_in_startofpacket;
  input  stream_in_endofpacket;
  input  [IEW:0] stream_in_empty;
  input  stream_in_valid;
  input  stream_out_ready;
  output stream_in_ready;
  output reg [ODW:0] stream_out_data;
  output reg stream_out_startofpacket;
  output reg stream_out_endofpacket;
  output reg [OEW:0] stream_out_empty;
  output reg stream_out_valid;
  wire [9:0] r;
  wire [9:0] g;
  wire [9:0] b;
  wire [9:0] a;
  wire [ODW:0] converted_data;

  
  always @(posedge clk)
      begin
        if (reset) 
          begin
            stream_out_data <= 'b0;
            stream_out_startofpacket <= 1'b0;
            stream_out_endofpacket <= 1'b0;
            stream_out_empty <= 'b0;
            stream_out_valid <= 1'b0;
          end
        else if (stream_out_ready | ~stream_out_valid) 
          begin
            stream_out_data <= converted_data;
            stream_out_startofpacket <= stream_in_startofpacket;
            stream_out_endofpacket <= stream_in_endofpacket;
            stream_out_empty <= stream_in_empty;
            stream_out_valid <= stream_in_valid;
          end
          
      end
  assign stream_in_ready = stream_out_ready | ~stream_out_valid;
  assign r = {stream_in_data[15:11],stream_in_data[15:11]};
  assign g = {stream_in_data[10:5],stream_in_data[10:7]};
  assign b = {stream_in_data[4:0],stream_in_data[4:0]};
  assign a = ALPHA;
  assign converted_data[29:20] = r[9:0];
  assign converted_data[19:10] = g[9:0];
  assign converted_data[9:0] = b[9:0];
endmodule

