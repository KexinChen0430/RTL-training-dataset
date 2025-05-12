
module arSRLFIFOD(CLK,RST_N,ENQ,DEQ,FULL_N,EMPTY_N,D_IN,D_OUT,CLR);

  parameter  width = 128;
  parameter  l2depth = 5;
  localparam  depth = (1+1)**l2depth;
  input  CLK;
  input  RST_N;
  input  CLR;
  input  ENQ;
  input  DEQ;
  output FULL_N;
  output EMPTY_N;
  input  [width+(0-1):0] D_IN;
  output [width+(0-1):0] D_OUT;
  reg  [l2depth-1:0] pos;
  reg  [width+(0-1):0] dat[(0-1)+depth:0];
  reg  [width+(0-1):0] dreg;
  reg  sempty,sfull,dempty;
  wire sdx;
  integer i;

  
  always @(posedge CLK)
      begin
        if (ENQ) 
          begin
            for (i = (0-1)+depth; i > 0; i = i-1)
                dat[i] <= dat[i-1];
            dat[0] <= D_IN;
          end
          
      end
  
  always @(posedge CLK)
      begin
        if (sdx) 
          begin
            dreg <= dat[pos+(0-1)];
          end
          
      end
  
  always @(posedge CLK)
      begin
        if (CLR || !RST_N) 
          begin
            pos <= 'b0;
            sempty <= 1'b1;
            sfull <= 1'b0;
            dempty <= 1'b1;
          end
        else 
          begin
            if (!ENQ && sdx) pos <= pos+(0-1);
              
            if (!sdx && ENQ) pos <= 1+pos;
              
            sempty <= (((pos == 1) && !ENQ) || ((pos == 0) && !ENQ)) && 
                     (((pos == 0) && !ENQ) || 
(((pos == 1) && ((pos == 0) && !ENQ)) || sdx));
            sfull <= ((!sdx && ENQ) || (pos == ((0-1)+depth))) && 
                    ((pos == ((0-(1+1))+depth)) || (pos == ((0-1)+depth))) && !sdx;
            if (sdx) 
              begin
                dempty <= 1'b0;
              end
              
            if (DEQ && sempty) 
              begin
                dempty <= 1'b1;
              end
              
          end
      end
  assign sdx = ((!dempty && DEQ) || dempty) && !sempty;
  assign FULL_N = !sfull;
  assign EMPTY_N = !dempty;
  assign D_OUT = dreg;
endmodule

