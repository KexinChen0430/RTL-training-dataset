
module generic_sram_byte_en  #(parameter  DATA_WIDTH = 128, ADDRESS_WIDTH = 7)
  (input  i_clk,
   input  [DATA_WIDTH+(0-1):0] i_write_data,
   input  i_write_enable,
   input  [(0-1)+ADDRESS_WIDTH:0] i_address,
   input  [(DATA_WIDTH/8)+(0-1):0] i_byte_enable,
   output reg [DATA_WIDTH+(0-1):0] o_read_data);

  reg  [DATA_WIDTH+(0-1):0] mem[0:(0-1)+(2**ADDRESS_WIDTH)];
  integer i;

  
  always @(posedge i_clk)
      begin
        o_read_data <= i_write_enable ? {DATA_WIDTH{1'd0}} : mem[i_address];
        if (i_write_enable) 
          for (i = 0; i < (DATA_WIDTH/8); i = 1+i)
              begin
                mem[i_address][i*8] <= i_byte_enable[i] ? i_write_data[i*8] : mem[i_address][i*8];
                mem[i_address][1+(i*8)] <= i_byte_enable[i] ? i_write_data[1+(i*8)] : mem[i_address][1+(i*8)];
                mem[i_address][2+(i*8)] <= i_byte_enable[i] ? i_write_data[2+(i*8)] : mem[i_address][2+(i*8)];
                mem[i_address][3+(i*8)] <= i_byte_enable[i] ? i_write_data[3+(i*8)] : mem[i_address][3+(i*8)];
                mem[i_address][4+(i*8)] <= i_byte_enable[i] ? i_write_data[4+(i*8)] : mem[i_address][4+(i*8)];
                mem[i_address][5+(i*8)] <= i_byte_enable[i] ? i_write_data[5+(i*8)] : mem[i_address][5+(i*8)];
                mem[i_address][6+(i*8)] <= i_byte_enable[i] ? i_write_data[6+(i*8)] : mem[i_address][6+(i*8)];
                mem[i_address][7+(i*8)] <= i_byte_enable[i] ? i_write_data[7+(i*8)] : mem[i_address][7+(i*8)];
              end
          
      end
endmodule

