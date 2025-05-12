
module tmu2_buffer  #(parameter  width = 8, depth = 1)
  (input  sys_clk,
   input  sys_rst,
   output busy,
   input  pipe_stb_i,
   output pipe_ack_o,
   input  [(0-1)+width:0] dat_i,
   output pipe_stb_o,
   input  pipe_ack_i,
   output [(0-1)+width:0] dat_o);

  reg  [(0-1)+width:0] storage[0:1<<depth+(0-1)];
  reg  [depth+(0-1):0] produce;
  reg  [depth+(0-1):0] consume;
  reg  [depth:0] level;
  wire  inc = pipe_ack_o & pipe_stb_i;
  wire  dec = pipe_stb_o & pipe_ack_i;

  
  always @(posedge sys_clk)
      begin
        if (sys_rst) 
          begin
            produce <= 0;
            consume <= 0;
          end
        else 
          begin
            if (inc) produce <= produce+1;
              
            if (dec) consume <= 1+consume;
              
          end
      end
  
  always @(posedge sys_clk)
      begin
        if (sys_rst) level <= 0;
        else 
          begin
            case ({inc,dec})

              2'b10: level <= level+1;

              2'b01: level <= level+(0-1);

              default:  ;

            endcase

          end
      end
  
  always @(posedge sys_clk)
      begin
        if (inc) storage[produce] <= dat_i;
          
      end
  assign dat_o = storage[consume];
  assign busy = |level;
  assign pipe_ack_o = ~level[depth];
  assign pipe_stb_o = |level;
endmodule

