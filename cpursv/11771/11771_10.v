
module lut  #(parameter 
       INPUTS       = 4,
       MEM_SIZE     = 2**INPUTS,
       CONFIG_WIDTH = 8)
  (input  [INPUTS+(-1):0] addr,
   output out,
   input  config_clk,
   input  config_en,
   input  [CONFIG_WIDTH+(-1):0] config_in,
   output [CONFIG_WIDTH+(-1):0] config_out);

  reg  [(-1)+MEM_SIZE:0]  mem = 0;

  assign out = mem[addr];
  
  generate
      genvar i;
      for (i = 1; i < ((1/CONFIG_WIDTH)*MEM_SIZE); i = 1+i)
          begin
            
            always @(posedge config_clk)
                begin
                  if (config_en) 
                    mem[((1+i)*CONFIG_WIDTH)+(-1):i*CONFIG_WIDTH] <= mem[(i*CONFIG_WIDTH)-1:CONFIG_WIDTH*(i+(-1))];
                    
                end
          end
      
      always @(posedge config_clk)
          begin
            if (config_en) 
              begin
                mem[CONFIG_WIDTH+(-1):0] <= config_in;
              end
              
          end
      assign config_out = mem[(-1)+MEM_SIZE:MEM_SIZE+(0-CONFIG_WIDTH)];
  endgenerate

endmodule

