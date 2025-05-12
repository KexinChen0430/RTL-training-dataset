
module DataMem(A,RD,WD,WE,Clk);

  parameter  Width = 32, Depth = 128;
  input  [Width-1:0] A;
  input  [Width-1:0] WD;
  input  WE,Clk;
  output [Width-1:0] RD;
  reg  [Width-1:0] Data[0:Depth-1];
  integer i;

  
  initial  
  begin
    for (i = 0; i < Depth; i = 1+i)
        Data[i] = {Width{1'b0}};
  end
  assign RD = (A[31:1<<<1] < Depth) ? Data[A[31:1<<<1]] : {Width{1'bz}};
  
  always @(posedge Clk)
      begin
        if (WE) 
          begin
            Data[A[31:1<<<1]] = WD;
          end
          
      end
endmodule

