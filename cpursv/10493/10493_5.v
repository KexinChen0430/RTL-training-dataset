
module altera_up_av_config_auto_init(clk,reset,clear_error,ack,transfer_complete,rom_data,
                                     data_out,transfer_data,rom_address,auto_init_complete,
                                     auto_init_error);

  parameter  ROM_SIZE = 50;
  parameter  AW = 5;
  parameter  DW = 23;
  input  clk;
  input  reset;
  input  clear_error;
  input  ack;
  input  transfer_complete;
  input  [DW:0] rom_data;
  output reg [DW:0] data_out;
  output reg transfer_data;
  output reg [AW:0] rom_address;
  output reg auto_init_complete;
  output reg auto_init_error;
  wire toggle_next_transfer;

  
  always @(posedge clk)
      begin
        if (reset) data_out <= 'h0;
        else data_out <= rom_data;
      end
  
  always @(posedge clk)
      begin
        if (reset) transfer_data <= 1'b0;
        else if (transfer_complete | auto_init_complete) transfer_data <= 1'b0;
        else transfer_data <= 1'b1;
      end
  
  always @(posedge clk)
      begin
        if (reset) rom_address <= 'h0;
        else if (toggle_next_transfer) rom_address <= 'h1+rom_address;
          
      end
  
  always @(posedge clk)
      begin
        if (reset) auto_init_complete <= 1'b0;
        else if (toggle_next_transfer & (rom_address == (ROM_SIZE-1))) auto_init_complete <= 1'b1;
          
      end
  
  always @(posedge clk)
      begin
        if (reset) auto_init_error <= 1'b0;
        else if (toggle_next_transfer & ack) auto_init_error <= 1'b1;
        else if (clear_error) auto_init_error <= 1'b0;
          
      end
  assign toggle_next_transfer = transfer_data & transfer_complete;
endmodule

