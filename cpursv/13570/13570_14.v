
module single_port_ram  #(parameter  ADDR_WIDTH = 1, DATA_WIDTH = 1)
  (input  [(0-1)+ADDR_WIDTH:0] addr,
   input  [(0-1)+DATA_WIDTH:0] data,
   input  we,
   input  clock,
   output reg [(0-1)+DATA_WIDTH:0] out);

  localparam  MEM_DEPTH = (1+1)**ADDR_WIDTH;
  reg  [(0-1)+DATA_WIDTH:0] Mem[MEM_DEPTH-1:0];

  
  always @(posedge clock)
      begin
        if (we) 
          begin
            Mem[addr] = data;
          end
          
        out = Mem[addr];
      end
endmodule

