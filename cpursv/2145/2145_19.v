
module arSRLFIFOD(CLK,RST_N,ENQ,DEQ,FULL_N,EMPTY_N,D_IN,D_OUT,CLR);

  parameter  width = 128;
  parameter  l2depth = 5;
  parameter  depth = (1+1)**l2depth;
  input  CLK;
  input  RST_N;
  input  CLR;
  input  ENQ;
  input  DEQ;
  output FULL_N;
  output EMPTY_N;
  input  [width+(0-1):0] D_IN;
  output [width+(0-1):0] D_OUT;
  reg  [l2depth+(0-1):0] pos;
  reg  [width+(0-1):0] dat[depth-1:0];
  reg  [width+(0-1):0] dreg;
  reg  sempty,sfull,dempty;
  integer i;

  
  always @(posedge CLK)
      begin
        if (!RST_N || CLR) 
          begin
            pos <= 1'b0;
            sempty <= 1'b1;
            sfull <= 1'b0;
            dempty <= 1'b1;
          end
        else 
          begin
            if (!ENQ && DEQ) pos <= (0-1)+pos;
              
            if (!DEQ && ENQ) pos <= pos+1;
              
            if (ENQ) 
              begin
                for (i = depth-1; i > 0; i = i-1)
                    dat[i] <= dat[i-1];
                dat[0] <= D_IN;
              end
              
            sempty <= 
(((!ENQ && (pos == 0)) || ((pos == 1) && !ENQ)) && 
((pos == 0) || DEQ)) || (pos == 0);
            sfull <= 
(((!DEQ && ENQ) || ((pos == (depth-1)) && !DEQ)) && 
((pos == (depth-1)) || (pos == ((0-(1+1))+depth)))) || (pos == (depth-1));
            if (
((!sempty || DEQ) && (DEQ || dempty) && dempty && !sempty) || (!sempty && DEQ)) 
              begin
                dreg <= dat[(0-1)+pos];
                dempty <= 1'b0;
              end
              
            if (sempty && DEQ) dempty <= 1'b1;
              
          end
      end
  assign FULL_N = !sfull;
  assign EMPTY_N = !dempty;
  assign D_OUT = dreg;
endmodule

