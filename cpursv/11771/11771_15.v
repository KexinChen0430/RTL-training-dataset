
module lut  #(parameter 
       INPUTS       = 4,
       MEM_SIZE     = 1<<<INPUTS,
       CONFIG_WIDTH = 8)
  (input  [INPUTS-1:0] addr,
   output out,
   input  config_clk,
   input  config_en,
   input  [(-1)+CONFIG_WIDTH:0] config_in,
   output [(-1)+CONFIG_WIDTH:0] config_out);

  reg  [MEM_SIZE-1:0]  mem = 0;

  assign out = mem[addr];
  
  generate
      genvar i;
      for (i = 1; i < (MEM_SIZE/CONFIG_WIDTH); i = 1+i)
          begin
            
            always @(posedge config_clk)
                begin
                  if (config_en) 
                    mem[((1+i)*CONFIG_WIDTH)-1:i*CONFIG_WIDTH] <= mem[(-1)+(i*CONFIG_WIDTH):CONFIG_WIDTH*((-1)+i)];
                    
                end
          end
      
      always @(posedge config_clk)
          begin
            if (config_en) 
              begin
                mem[(-1)+CONFIG_WIDTH:0] <= config_in;
              end
              
          end
      assign config_out = mem[MEM_SIZE-1:MEM_SIZE+(0-CONFIG_WIDTH)];
  endgenerate

endmodule

