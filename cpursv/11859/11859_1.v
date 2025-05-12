
module altera_up_av_config_auto_init_d5m(rom_address,exposure,rom_data);

  parameter  D5M_COLUMN_SIZE = 16'd2591;
  parameter  D5M_ROW_SIZE = 16'd1943;
  parameter  D5M_COLUMN_BIN = 16'h0000;
  parameter  D5M_ROW_BIN = 16'h0000;
  input  [4:0] rom_address;
  input  [15:0] exposure;
  output [35:0] rom_data;
  reg  [31:0] data;

  assign rom_data = {data[31:24],1'b0,data[23:16],1'b0,data[15:8],1'b0,data[7:0],1'b0};
  
  always @(*)
      begin
        case (rom_address)

          0: data <= {8'hBA,8'h00,16'h0000};

        endcase

      end
endmodule

