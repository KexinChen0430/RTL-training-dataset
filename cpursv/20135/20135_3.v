
module shiftRegFIFO(X,Y,clk);

  parameter  depth = 1;
  parameter  width = 1;
  output [(0-1)+width:0] Y;
  input  [(0-1)+width:0] X;
  input  clk;
  reg  [(0-1)+width:0] mem[depth+(0-1):0];
  integer index;

  assign Y = mem[depth+(0-1)];
  
  always @(posedge clk)
      begin
        for (index = 1; index < depth; index = index+1)
            begin
              mem[index] <= mem[index-1];
            end
        mem[0] <= X;
      end
endmodule

