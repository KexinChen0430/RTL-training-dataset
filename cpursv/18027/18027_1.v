
module generic_sram_byte_en  #(parameter  DATA_WIDTH = 128, ADDRESS_WIDTH = 7)
  (input  i_clk,
   input  [(0-1)+DATA_WIDTH:0] i_write_data,
   input  i_write_enable,
   input  [ADDRESS_WIDTH-1:0] i_address,
   input  [((1/8)*DATA_WIDTH)+(0-1):0] i_byte_enable,
   output reg [(0-1)+DATA_WIDTH:0] o_read_data);

  reg  [(0-1)+DATA_WIDTH:0] mem[0:((1+1)**ADDRESS_WIDTH)-1];
  integer i;

  
  always @(posedge i_clk)
      begin
        o_read_data <= i_write_enable ? {DATA_WIDTH{1'd0}} : mem[i_address];
        if (i_write_enable) 
          for (i = 0; i < ((1/8)*DATA_WIDTH); i = 1+i)
              begin
                mem[i_address][i*8] <= i_byte_enable[i] ? i_write_data[i*8] : mem[i_address][i*8];
                mem[i_address][1+(i*8)] <= i_byte_enable[i] ? i_write_data[1+(i*8)] : mem[i_address][1+(i*8)];
                mem[i_address][(1+1)+(i*8)] <= i_byte_enable[i] ? i_write_data[(1+1)+(i*8)] : mem[i_address][(1+1)+(i*8)];
                mem[i_address][(i*8)+3] <= i_byte_enable[i] ? i_write_data[(i*8)+3] : mem[i_address][(i*8)+3];
                mem[i_address][(i*8)+4] <= i_byte_enable[i] ? i_write_data[(i*8)+4] : mem[i_address][(i*8)+4];
                mem[i_address][5+(i*8)] <= i_byte_enable[i] ? i_write_data[5+(i*8)] : mem[i_address][5+(i*8)];
                mem[i_address][6+(i*8)] <= i_byte_enable[i] ? i_write_data[6+(i*8)] : mem[i_address][6+(i*8)];
                mem[i_address][(i*8)+7] <= i_byte_enable[i] ? i_write_data[(i*8)+7] : mem[i_address][(i*8)+7];
              end
          
      end
endmodule

