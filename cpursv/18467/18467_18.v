
module tmu2_buffer  #(parameter  width = 8, depth = 1)
  (input  sys_clk,
   input  sys_rst,
   output busy,
   input  pipe_stb_i,
   output pipe_ack_o,
   input  [width+(0-1):0] dat_i,
   output pipe_stb_o,
   input  pipe_ack_i,
   output [width+(0-1):0] dat_o);

  reg  [width+(0-1):0] storage[0:1<<depth+(0-1)];
  reg  [depth+(0-1):0] produce;
  reg  [depth+(0-1):0] consume;
  reg  [depth:0] level;
  wire  inc = pipe_ack_o & pipe_stb_i;
  wire  dec = pipe_ack_i & pipe_stb_o;

  
  always @(posedge sys_clk)
      begin
        if (sys_rst) 
          begin
            produce <= 0;
            consume <= 0;
          end
        else 
          begin
            if (inc) produce <= 1+produce;
              
            if (dec) consume <= consume+1;
              
          end
      end
  
  always @(posedge sys_clk)
      begin
        if (sys_rst) level <= 0;
        else 
          begin
            case ({inc,dec})

              2'b10: level <= 1+level;

              2'b01: level <= (0-1)+level;

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

