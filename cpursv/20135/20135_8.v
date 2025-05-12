
module shiftRegFIFO(X,Y,clk);

  parameter  depth = 1;
  parameter  width = 1;
  output [(0-1)+width:0] Y;
  input  [(0-1)+width:0] X;
  input  clk;
  reg  [(0-1)+width:0] mem[(0-1)+depth:0];
  integer index;

  assign Y = mem[(0-1)+depth];
  
  always @(posedge clk)
      begin
        for (index = 1; index < depth; index = 1+index)
            begin
              mem[index] <= mem[index+(0-1)];
            end
        mem[0] <= X;
      end
endmodule

