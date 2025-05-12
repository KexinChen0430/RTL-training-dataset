
module RAM32kx8(input  CLK,
                input  [14:0] AB,
                input  CS,
                input  READ,
                output [7:0] DO,
                input  [7:0] DI);

  reg  [7:0] mem[0:32767];
  reg  [7:0] R;
  integer i;

  assign DO = CS ? R : 8'bZ;
  
  initial  
  begin
    for (i = 0; i < 32768; i = 1+i)
        mem[i] <= 0;
  end
  
  always @(posedge CLK)
      if (CS) 
        if (READ) R <= mem[AB];
        else mem[AB] <= DI;
        
endmodule

