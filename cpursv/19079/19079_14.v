
module dotproduct16x46(Ax,Ay,Az,Bx,By,Bz,C,clk);

  input  [16-1:0] Ax;
  input  [16-1:0] Ay;
  input  [16-1:0] Az;
  input  [46-1:0] Bx;
  input  [46-1:0] By;
  input  [46-1:0] Bz;
  output [(46+16)+1:0] C;
  reg  [(46+16)+1:0] C;
  input  clk;
  reg  [(46+16)-1:0] AxBx;
  reg  [(46+16)-1:0] AyBy;
  reg  [(46+16)-1:0] AzBz;

  
  always @(posedge clk)
      begin
        AxBx <= Ax*Bx;
        AyBy <= By*Ay;
        AzBz <= Az*Bz;
        C <= ({AzBz[(46+16)-1],AzBz[(46+16)-1],AzBz}+{AxBx[(46+16)-1],AxBx[(46+16)-1],AxBx})+{AyBy[(46+16)-1],AyBy[(46+16)-1],AyBy};
      end
endmodule

