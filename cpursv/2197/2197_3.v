
module IMUL(input  wire [3:0] A,
            input  wire [3:0] B,
            output reg [7:0] out);

  reg  rC1,rC2,rC3;
  reg  [2:0] rT1,rT2;

  
  always @(*)
      begin
        out[0] = B[0] & A[0];
        {rC1,out[1]} = (A[1] & B[0])+(B[1] & A[0]);
        {rC1,rT1[0]} = (rC1+(B[0] & A[2]))+(A[1] & B[1]);
        {rC2,out[2]} = rT1[0]+(A[0] & B[2]);
        {rC1,rT1[1]} = (rC1+(B[1] & A[2]))+(B[0] & A[3]);
        {rC2,rT2[0]} = rC2+((A[1] & B[2])+rT1[1]);
        {rC3,out[3]} = rT2[0]+(B[3] & A[0]);
        {rC1,rT1[2]} = rC1+(A[3] & B[1]);
        {rC2,rT2[1]} = (A[2] & B[2])+(rT1[2]+rC2);
        {rC3,out[4]} = rC3+(rT2[1]+(A[1] & B[3]));
        {rC2,rT2[2]} = rC1+((B[2] & A[3])+rC2);
        {rC3,out[5]} = (A[2] & B[3])+(rC3+rT2[2]);
        {out[7],out[6]} = rC2+(rC3+(A[3] & B[3]));
      end
endmodule

