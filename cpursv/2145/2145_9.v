
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
  input  [(-1)+width:0] D_IN;
  output [(-1)+width:0] D_OUT;
  reg  [l2depth+(-1):0] pos;
  reg  [(-1)+width:0] dat[depth-1:0];
  reg  [(-1)+width:0] dreg;
  reg  sempty,sfull,dempty;
  integer i;

  
  always @(posedge CLK)
      begin
        if (CLR || !RST_N) 
          begin
            pos <= 1'b0;
            sempty <= 1'b1;
            sfull <= 1'b0;
            dempty <= 1'b1;
          end
        else 
          begin
            if (!ENQ && DEQ) pos <= pos+(-1);
              
            if (ENQ && !DEQ) pos <= pos+1;
              
            if (ENQ) 
              begin
                for (i = depth-1; i > 0; i = i-1)
                    dat[i] <= dat[i-1];
                dat[0] <= D_IN;
              end
              
            sempty <= 
(((pos == 0) || (pos == 1)) && 
(
((pos == 1) && ((!ENQ && (pos == 0)) || (!ENQ && DEQ))) || ((pos == 0) && (pos == 1)))) || (pos == 0);
            sfull <= 
(((pos == (depth-1)) || (pos == (depth-(1+1)))) && 
(ENQ && !DEQ && (pos == (depth-(1+1))))) || (pos == (depth-1));
            if (!sempty && 
                ((DEQ && !dempty && (dempty || !sempty)) || dempty)) 
              begin
                dreg <= dat[pos+(-1)];
                dempty <= 1'b0;
              end
              
            if (DEQ && sempty) dempty <= 1'b1;
              
          end
      end
  assign FULL_N = !sfull;
  assign EMPTY_N = !dempty;
  assign D_OUT = dreg;
endmodule

