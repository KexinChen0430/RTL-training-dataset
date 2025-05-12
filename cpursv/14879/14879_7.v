
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
  input  [(0-1)+width:0] D_IN;
  output [(0-1)+width:0] D_OUT;
  reg  [(0-1)+l2depth:0] pos;
  reg  [(0-1)+width:0] dat[depth-1:0];
  reg  [(0-1)+width:0] dreg;
  reg  sempty,sfull,dempty;
  wire sdx;
  integer i;

  
  always @(posedge CLK)
      begin
        if (ENQ) 
          begin
            for (i = depth-1; i > 0; i = i+(0-1))
                dat[i] <= dat[i+(0-1)];
            dat[0] <= D_IN;
          end
          
      end
  
  always @(posedge CLK)
      begin
        if (sdx) 
          begin
            dreg <= dat[pos-1];
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
            if (sdx && !ENQ) pos <= pos-1;
              
            if (ENQ && !sdx) pos <= pos+1;
              
            sempty <= ((!ENQ && (pos == 0)) || (sdx && !ENQ)) && 
                     ((pos == 1) || (pos == 0)) && ((pos == 1) || !ENQ);
            sfull <= 
(ENQ && !sdx && 
((pos == ((-1<<<1)+depth)) || (pos == (depth-1))) && ((pos == ((-1<<<1)+depth)) || !sdx)) || (!sdx && (pos == (depth-1)));
            if (sdx) 
              begin
                dempty <= 1'b0;
              end
              
            if (sempty && DEQ) 
              begin
                dempty <= 1'b1;
              end
              
          end
      end
  assign sdx = (!sempty && !dempty && (DEQ && !sempty)) || 
               (!sempty && dempty);
  assign FULL_N = !sfull;
  assign EMPTY_N = !dempty;
  assign D_OUT = dreg;
endmodule

