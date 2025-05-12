
module arSRLFIFOD(CLK,RST_N,ENQ,DEQ,FULL_N,EMPTY_N,D_IN,D_OUT,CLR);

  parameter  width = 128;
  parameter  l2depth = 5;
  localparam  depth = 1<<<1**l2depth;
  input  CLK;
  input  RST_N;
  input  CLR;
  input  ENQ;
  input  DEQ;
  output FULL_N;
  output EMPTY_N;
  input  [(-1)+width:0] D_IN;
  output [(-1)+width:0] D_OUT;
  reg  [l2depth-1:0] pos;
  reg  [(-1)+width:0] dat[depth+(-1):0];
  reg  [(-1)+width:0] dreg;
  reg  sempty,sfull,dempty;
  wire sdx;
  integer i;

  
  always @(posedge CLK)
      begin
        if (ENQ) 
          begin
            for (i = depth+(-1); i > 0; i = (-1)+i)
                dat[i] <= dat[(-1)+i];
            dat[0] <= D_IN;
          end
          
      end
  
  always @(posedge CLK)
      begin
        if (sdx) 
          begin
            dreg <= dat[(-1)+pos];
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
            if (sdx && !ENQ) pos <= (-1)+pos;
              
            if (!sdx && ENQ) pos <= 1+pos;
              
            sempty <= 
(!ENQ && (((pos == 0) && !ENQ) || sdx) && (pos == 1)) || ((pos == 0) && !ENQ);
            sfull <= ((pos == (depth+(-1))) && !sdx) || 
                    ((pos == ((-1<<<1)+depth)) && ENQ && !sdx);
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
  assign sdx = (!dempty && (DEQ && !sempty)) || (!sempty && dempty);
  assign FULL_N = !sfull;
  assign EMPTY_N = !dempty;
  assign D_OUT = dreg;
endmodule

