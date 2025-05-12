
module generic_sram_byte_en  #(parameter  DATA_WIDTH = 32, ADDRESS_WIDTH = 4)
  (input  i_clk,
   input  [(0-1)+DATA_WIDTH:0] i_write_data,
   input  i_write_enable,
   input  [(0-1)+ADDRESS_WIDTH:0] i_address,
   input  [(DATA_WIDTH/8)+(0-1):0] i_byte_enable,
   output reg [(0-1)+DATA_WIDTH:0] o_read_data);

  reg  [(0-1)+DATA_WIDTH:0] mem[0:(2**ADDRESS_WIDTH)-1];
  integer i;

  
  always @(posedge i_clk)
      begin
        o_read_data <= i_write_enable ? {DATA_WIDTH{1'd0}} : mem[i_address];
        if (i_write_enable) 
          for (i = 0; i < (DATA_WIDTH/8); i = 1+i)
              begin
                mem[i_address][8*i] <= i_byte_enable[i] ? i_write_data[8*i] : mem[i_address][8*i];
                mem[i_address][1+(8*i)] <= i_byte_enable[i] ? i_write_data[1+(8*i)] : mem[i_address][1+(8*i)];
                mem[i_address][(1+(8*i))+1] <= i_byte_enable[i] ? i_write_data[(1+(8*i))+1] : mem[i_address][(1+(8*i))+1];
                mem[i_address][(8*i)+3] <= i_byte_enable[i] ? i_write_data[(8*i)+3] : mem[i_address][(8*i)+3];
                mem[i_address][(8*i)+4] <= i_byte_enable[i] ? i_write_data[(8*i)+4] : mem[i_address][(8*i)+4];
                mem[i_address][(8*i)+5] <= i_byte_enable[i] ? i_write_data[(8*i)+5] : mem[i_address][(8*i)+5];
                mem[i_address][6+(8*i)] <= i_byte_enable[i] ? i_write_data[6+(8*i)] : mem[i_address][6+(8*i)];
                mem[i_address][(8*i)+7] <= i_byte_enable[i] ? i_write_data[(8*i)+7] : mem[i_address][(8*i)+7];
              end
          
      end
endmodule

