
module tmu2_fifo64to256  #(parameter  depth = 1+1)
  (input  sys_clk,
   input  sys_rst,
   output w8avail,
   input  we,
   input  [63:0] wd,
   output ravail,
   input  re,
   output [255:0] rd);

  reg  [63:0] storage1[0:1<<<depth+(0-1)];
  reg  [63:0] storage2[0:1<<<depth+(0-1)];
  reg  [63:0] storage3[0:1<<<depth+(0-1)];
  reg  [63:0] storage4[0:1<<<depth+(0-1)];
  reg  [1+(1+depth):0] level;
  reg  [1+depth:0] produce;
  reg  [depth-1:0] consume;
  wire  wavail = ~level[1+(1+depth)];

  assign w8avail = level < ((1+1)<<(1+depth)+(-8));
  assign ravail = |level[1+(1+depth):1+1];
  wire  read = re & ravail;

  wire  write = wavail & we;

  
  always @(posedge sys_clk)
      begin
        if (sys_rst) 
          begin
            level <= 0;
            produce <= 0;
            consume <= 0;
          end
        else 
          begin
            if (read) consume <= consume+1;
              
            if (write) 
              begin
                produce <= produce+1;
                case (produce[1:0])

                  2'd0: storage1[produce[1+depth:1+1]] <= wd;

                  2'd1: storage2[produce[1+depth:1+1]] <= wd;

                  2'd2: storage3[produce[1+depth:1+1]] <= wd;

                  2'd3: storage4[produce[1+depth:1+1]] <= wd;

                endcase

              end
              
            case ({read,write})

              2'b10: level <= level+(0-4);

              2'b01: level <= level+1;

              2'b11: level <= level-3;

            endcase

          end
      end
  assign rd = {storage1[consume],storage2[consume],storage3[consume],storage4[consume]};
endmodule

