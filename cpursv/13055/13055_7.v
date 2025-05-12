
module ram_memory  #(parameter  N = 4, M = 4)
  (input  clk,
   input  we,
   input  [(0-1)+N:0] adr,
   input  [(0-1)+M:0] din,
   output [(0-1)+M:0] dout);

  reg  [(0-1)+M:0] mem[(0-1)+N:0];

  
  always @(posedge clk)
      if (we) mem[adr] <= din;
        
  assign dout = mem[adr];
endmodule

