
module ram_64x32(output reg [31:0] q,
                 input  [31:0] d,
                 input  [5:0] waddr,
                 input  [5:0] raddr,
                 input  we,
                 input  c);

  reg  [31:0] mem[63:0];

  
  always @(posedge c)
      begin
        if (we) mem[waddr] <= d;
          
        q <= mem[raddr];
      end
endmodule

