module rom 
  (
   input       clk, 
   input       reset_n, 
   input [5:0] addr, 
   output      load, 
   output      shift, 
   output      sclk, 
   output      output_enable_n, 
   output      latch_enable 
   );
   reg [4:0]   rom_data, data_reg; 
   always @(posedge clk, negedge reset_n)
     begin
        if (!reset_n) 
          begin
             data_reg <= 5'b00010; 
          end
        else 
          begin
             data_reg <= rom_data; 
          end
     end
   always @*
     begin
        case (addr) 
          6'd00: rom_data = 5'b10000;
          6'd01: rom_data = 5'b00000;
          6'd63: rom_data = 5'b00000;
        endcase 
     end 
   assign load = data_reg[4];
   assign shift = data_reg[3];
   assign sclk = data_reg[2];
   assign output_enable_n = data_reg[1];
   assign latch_enable = data_reg[0];
endmodule 