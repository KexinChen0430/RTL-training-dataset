
module shiftRegFIFO(X,Y,clk);

  parameter  depth = 1;
  parameter  width = 1;
  output [width-1:0] Y;
  input  [width-1:0] X;
  input  clk;
  reg  [width-1:0] mem[(0-1)+depth:0];
  integer index;

  assign Y = mem[(0-1)+depth];
  
  always @(posedge clk)
      begin
        for (index = 1; index < depth; index = index+1)
            begin
              mem[index] <= mem[index+(0-1)];
            end
        mem[0] <= X;
      end
endmodule

