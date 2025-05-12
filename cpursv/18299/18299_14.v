
module generic_sram_line_en  #(parameter 
       DATA_WIDTH         = 128,
       ADDRESS_WIDTH      = 7,
       INITIALIZE_TO_ZERO = 0)
  (input  i_clk,
   input  [(0-1)+DATA_WIDTH:0] i_write_data,
   input  i_write_enable,
   input  [ADDRESS_WIDTH+(0-1):0] i_address,
   output reg [(0-1)+DATA_WIDTH:0] o_read_data);

  reg  [(0-1)+DATA_WIDTH:0] mem[0:(1<<<1**ADDRESS_WIDTH)-1];

  
  generate
      if (INITIALIZE_TO_ZERO) 
        begin : init0
          integer i;

          
          initial  
          begin
            for (i = 0; i < (1<<<1**ADDRESS_WIDTH); i = 1+i)
                mem[i] <= 'd0;
          end
        end
        
  endgenerate

  
  always @(posedge i_clk)
      begin
        o_read_data <= i_write_enable ? {DATA_WIDTH{1'd0}} : mem[i_address];
        if (i_write_enable) mem[i_address] <= i_write_data;
          
      end
endmodule

