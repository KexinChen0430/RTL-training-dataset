
module shiftRegFIFO(X,Y,clk);

  parameter  depth = 1;
  parameter  width = 1;
  output [(-1)+width:0] Y;
  input  [(-1)+width:0] X;
  input  clk;
  reg  [(-1)+width:0] mem[depth+(-1):0];
  integer index;

  assign Y = mem[depth+(-1)];
  
  always @(posedge clk)
      begin
        for (index = 1; index < depth; index = 1+index)
            begin
              mem[index] <= mem[(-1)+index];
            end
        mem[0] <= X;
      end
endmodule

