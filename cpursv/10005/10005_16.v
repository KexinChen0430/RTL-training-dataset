
module hlsblockram(input  clk,
                   input  [(0-1)+ABITWIDTH:0] readaddr1,
                   output reg [(0-1)+BITWIDTH:0] readout1,
                   input  [(0-1)+ABITWIDTH:0] writeaddr1,
                   input  [(0-1)+BITWIDTH:0] writein1,
                   input  we);

  parameter  SIZE = 32;
  parameter  BITWIDTH = 32;
  parameter  ABITWIDTH = 32;
  reg  [(0-1)+BITWIDTH:0] mem[0:SIZE+(0-1)];

  
  always @(posedge clk)
      begin
        if (we) 
          begin
            mem[writeaddr1] = writein1;
          end
          
        readout1 <= mem[readaddr1];
      end
endmodule

