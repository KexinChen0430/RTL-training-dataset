
module generic_sram_byte_en  #(parameter  DATA_WIDTH = 32, ADDRESS_WIDTH = 4)
  (input  i_clk,
   input  [(0-1)+DATA_WIDTH:0] i_write_data,
   input  i_write_enable,
   input  [ADDRESS_WIDTH+(0-1):0] i_address,
   input  [(DATA_WIDTH/8)+(0-1):0] i_byte_enable,
   output reg [(0-1)+DATA_WIDTH:0] o_read_data);

  reg  [(0-1)+DATA_WIDTH:0] mem[0:(2**ADDRESS_WIDTH)-1];
  integer i;

  
  always @(posedge i_clk)
      begin
        o_read_data <= i_write_enable ? {DATA_WIDTH{1'd0}} : mem[i_address];
        if (i_write_enable) 
          for (i = 0; i < (DATA_WIDTH/8); i = i+1)
              begin
                mem[i_address][i*8] <= i_byte_enable[i] ? i_write_data[i*8] : mem[i_address][i*8];
                mem[i_address][(i*8)+1] <= i_byte_enable[i] ? i_write_data[(i*8)+1] : mem[i_address][(i*8)+1];
                mem[i_address][(i*8)+2] <= i_byte_enable[i] ? i_write_data[(i*8)+2] : mem[i_address][(i*8)+2];
                mem[i_address][3+(i*8)] <= i_byte_enable[i] ? i_write_data[3+(i*8)] : mem[i_address][3+(i*8)];
                mem[i_address][4+(i*8)] <= i_byte_enable[i] ? i_write_data[4+(i*8)] : mem[i_address][4+(i*8)];
                mem[i_address][(i*8)+5] <= i_byte_enable[i] ? i_write_data[(i*8)+5] : mem[i_address][(i*8)+5];
                mem[i_address][(i*8)+6] <= i_byte_enable[i] ? i_write_data[(i*8)+6] : mem[i_address][(i*8)+6];
                mem[i_address][7+(i*8)] <= i_byte_enable[i] ? i_write_data[7+(i*8)] : mem[i_address][7+(i*8)];
              end
          
      end
endmodule

