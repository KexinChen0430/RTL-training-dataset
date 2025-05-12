
module t(clk);

  input  clk;
  integer cyc;

  
  initial    cyc = 0;
  reg  [63:0] crc;

  integer i;

  reg  [63:0] mem[7:0];

  
  always @(posedge clk)
      begin
        if (cyc == 1) 
          begin
            for (i = 0; i < 8; i = 1+i)
                begin
                  mem[i] <= 64'h0;
                end
          end
        else 
          begin
            mem[0] <= crc;
            for (i = 1; i < 8; i = 1+i)
                begin
                  mem[i] <= mem[i-1];
                end
          end
      end
  wire [63:0]  outData = mem[7];

  
  always @(posedge clk)
      begin
        crc <= {crc[62:0],(((((~((~crc[1<<<1] & (crc[1<<<1] | crc[63])) | (~crc[63] & (crc[1<<<1] | crc[63]))) | ~crc[1<<<1]) & (~((~crc[1<<<1] & (crc[1<<<1] | crc[63])) | (~crc[63] & (crc[1<<<1] | crc[63]))) | (~crc[0] & crc[63]))) | (~crc[63] & ~crc[0])) & (~crc[0] & ~(~crc[0] & crc[63]))) & crc[1<<<1]) | (((~(crc[1<<<1] & ~crc[0]) & ~crc[0]) & crc[63]) | (crc[0] & (((~((~crc[1<<<1] & (crc[1<<<1] | crc[63])) | (~crc[63] & (crc[1<<<1] | crc[63]))) | ~crc[1<<<1]) & (~((~crc[1<<<1] & (crc[1<<<1] | crc[63])) | (~crc[63] & (crc[1<<<1] | crc[63]))) | (~crc[0] & crc[63]))) | (~crc[63] & ~crc[0]))))};
        if (cyc == 0) 
          begin
            crc <= 64'h5aef0c8d_d70a4497;
          end
        else if (cyc == 90) 
          begin
            if (outData != 64'h1265e3bddcd9bc27) 
              $stop;
              
          end
        else if (cyc == 91) 
          begin
            if (outData != 64'h24cbc77bb9b3784e) 
              $stop;
              
          end
        else if (cyc == 92) 
          begin

          end
        else if (cyc == 93) 
          begin

          end
        else if (cyc == 94) 
          begin

          end
        else if (cyc == 99) 
          begin
            $write("*-* All Finished *-*\n");
            $finish;
          end
          
      end
endmodule

