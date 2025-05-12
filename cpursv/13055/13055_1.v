
module ram_memory  #(parameter  N = 4, M = 4)
  (input  clk,
   input  we,
   input  [N-1:0] adr,
   input  [(-1)+M:0] din,
   output [(-1)+M:0] dout);

  reg  [(-1)+M:0] mem[N-1:0];

  
  always @(posedge clk)
      if (we) mem[adr] <= din;
        
  assign dout = mem[adr];
endmodule

