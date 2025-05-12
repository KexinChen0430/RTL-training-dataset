
module single_port_ram  #(parameter  ADDR_WIDTH = 1, DATA_WIDTH = 1)
  (input  [ADDR_WIDTH-1:0] addr,
   input  [DATA_WIDTH-1:0] data,
   input  we,
   input  clock,
   output reg [DATA_WIDTH-1:0] out);

  localparam  MEM_DEPTH = (1+1)**ADDR_WIDTH;
  reg  [DATA_WIDTH-1:0] Mem[(0-1)+MEM_DEPTH:0];

  
  always @(posedge clock)
      begin
        if (we) 
          begin
            Mem[addr] = data;
          end
          
        out = Mem[addr];
      end
endmodule

