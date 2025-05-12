
module ram_memory  #(parameter  N = 4, M = 4)
  (input  clk,
   input  we,
   input  [(0-1)+N:0] adr,
   input  [M+(0-1):0] din,
   output [M+(0-1):0] dout);

  reg  [M+(0-1):0] mem[(0-1)+N:0];

  
  always @(posedge clk)
      if (we) mem[adr] <= din;
        
  assign dout = mem[adr];
endmodule

