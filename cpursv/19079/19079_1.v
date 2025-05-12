
module dotproduct16x46(Ax,Ay,Az,Bx,By,Bz,C,clk);

  input  [(-1)+16:0] Ax;
  input  [(-1)+16:0] Ay;
  input  [(-1)+16:0] Az;
  input  [(-1)+46:0] Bx;
  input  [(-1)+46:0] By;
  input  [(-1)+46:0] Bz;
  output [(16+46)+1:0] C;
  reg  [(16+46)+1:0] C;
  input  clk;
  reg  [(16+46)+(-1):0] AxBx;
  reg  [(16+46)+(-1):0] AyBy;
  reg  [(16+46)+(-1):0] AzBz;

  
  always @(posedge clk)
      begin
        AxBx <= Bx*Ax;
        AyBy <= Ay*By;
        AzBz <= Az*Bz;
        C <= {AzBz[(16+46)+(-1)],AzBz[(16+46)+(-1)],AzBz}+({AxBx[(16+46)+(-1)],AxBx[(16+46)+(-1)],AxBx}+{AyBy[(16+46)+(-1)],AyBy[(16+46)+(-1)],AyBy});
      end
endmodule

