
module ram_memory  #(parameter  N = 4, M = 4)
  (input  clk,
   input  we,
   input  [(-1)+N:0] adr,
   input  [M-1:0] din,
   output [M-1:0] dout);

  reg  [M-1:0] mem[(-1)+N:0];

  
  always @(posedge clk)
      if (we) mem[adr] <= din;
        
  assign dout = mem[adr];
endmodule

