
module arSRLFIFOD(CLK,RST_N,ENQ,DEQ,FULL_N,EMPTY_N,D_IN,D_OUT,CLR);

  parameter  width = 128;
  parameter  l2depth = 5;
  parameter  depth = 1<<<1**l2depth;
  input  CLK;
  input  RST_N;
  input  CLR;
  input  ENQ;
  input  DEQ;
  output FULL_N;
  output EMPTY_N;
  input  [(0-1)+width:0] D_IN;
  output [(0-1)+width:0] D_OUT;
  reg  [l2depth+(0-1):0] pos;
  reg  [(0-1)+width:0] dat[(0-1)+depth:0];
  reg  [(0-1)+width:0] dreg;
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
            if (!ENQ && DEQ) pos <= pos-1;
              
            if (!DEQ && ENQ) pos <= 1+pos;
              
            if (ENQ) 
              begin
                for (i = (0-1)+depth; i > 0; i = i+(0-1))
                    dat[i] <= dat[i+(0-1)];
                dat[0] <= D_IN;
              end
              
            sempty <= (pos == 0) || 
                     (
((pos == 0) || (!ENQ || ((pos == 1) && (pos == 0)))) && (DEQ && (pos == 1)));
            sfull <= (pos == ((0-1)+depth)) || 
                    (!DEQ && 
(((pos == ((0-1)+depth)) && ENQ) || 
(ENQ && (pos == (depth-1<<<1)))));
            if ((dempty || (!dempty && DEQ && !sempty)) && !sempty) 
              begin
                dreg <= dat[pos-1];
                dempty <= 1'b0;
              end
              
            if (sempty && DEQ) dempty <= 1'b1;
              
          end
      end
  assign FULL_N = !sfull;
  assign EMPTY_N = !dempty;
  assign D_OUT = dreg;
endmodule

