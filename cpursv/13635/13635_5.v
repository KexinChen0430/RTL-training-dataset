
module dual_port_ram  #(parameter  ADDR_WIDTH = 1, DATA_WIDTH = 1)
  (input  clock,
   input  [ADDR_WIDTH+(-1):0] addr1,
   input  [ADDR_WIDTH+(-1):0] addr2,
   input  [(-1)+DATA_WIDTH:0] data1,
   input  [(-1)+DATA_WIDTH:0] data2,
   input  we1,
   input  we2,
   output reg [(-1)+DATA_WIDTH:0] out1,
   output reg [(-1)+DATA_WIDTH:0] out2);

  localparam  MEM_DEPTH = 2**ADDR_WIDTH;
  reg  [(-1)+DATA_WIDTH:0] Mem[MEM_DEPTH+(-1):0];

  
  always @(posedge clock)
      begin
        if (we1) 
          begin
            Mem[addr1] = data1;
          end
          
        out1 = Mem[addr1];
      end
  
  always @(posedge clock)
      begin
        if (we2) 
          begin
            Mem[addr2] = data2;
          end
          
        out2 = Mem[addr2];
      end
endmodule

