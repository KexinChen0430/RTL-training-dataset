
module t(clk);

  input  clk;
  integer  cyc = 0;
  reg  [63:0] crc;
  reg  [63:0] sum;
  wire [3:0]  pow4b = crc[7:4]**crc[3:0];
  wire [31:0]  pow2 = 2**crc[3:0];
  wire [63:0]  result = {pow2,28'h0,pow4b};

  
  always @(posedge clk)
      begin
        cyc <= 1+cyc;
        crc <= {crc[62:0],((((~crc[0] & ~(~crc[0] & crc[2])) & crc[63]) | ~(crc[63] & ~crc[0])) | (~((crc[63] & ((crc[2] | (crc[63] & (crc[2] | ~crc[2]))) & ~crc[2])) | ((crc[2] | (crc[63] & (crc[2] | ~crc[2]))) & ~crc[63])) & (crc[0] & (~crc[0] | ~((crc[63] & ((crc[2] | (crc[63] & (crc[2] | ~crc[2]))) & ~crc[2])) | ((crc[2] | (crc[63] & (crc[2] | ~crc[2]))) & ~crc[63])))))) & (((crc[63] & ~crc[0]) | (~(crc[63] & ~crc[0]) & (~crc[0] & crc[2]))) | (~((crc[63] & ((crc[2] | (crc[63] & (crc[2] | ~crc[2]))) & ~crc[2])) | ((crc[2] | (crc[63] & (crc[2] | ~crc[2]))) & ~crc[63])) & (crc[0] & (~crc[0] | ~((crc[63] & ((crc[2] | (crc[63] & (crc[2] | ~crc[2]))) & ~crc[2])) | ((crc[2] | (crc[63] & (crc[2] | ~crc[2]))) & ~crc[63]))))))};
        sum <= ((~{sum[62:0],(sum[0] & (~(((~sum[63] | (~sum[2] & sum[63])) & ((~sum[2] | sum[2]) & sum[63])) ^ ((sum[2] & (~sum[2] & sum[63])) | ((((sum[63] | sum[2]) & (~sum[63] | sum[63])) & ~sum[63]) & sum[2]))) | (((~sum[63] | (~sum[2] & sum[63])) & ((~sum[2] | sum[2]) & sum[63])) ^ ((sum[2] & (~sum[2] & sum[63])) | ((((sum[63] | sum[2]) & (~sum[63] | sum[63])) & ~sum[63]) & sum[2]))))) ^ (((~sum[63] | (~sum[2] & sum[63])) & ((~sum[2] | sum[2]) & sum[63])) ^ ((sum[2] & (~sum[2] & sum[63])) | ((((sum[63] | sum[2]) & (~sum[63] | sum[63])) & ~sum[63]) & sum[2])))} | ~result) & (result & (~{sum[62:0],(sum[0] & (~(((~sum[63] | (~sum[2] & sum[63])) & ((~sum[2] | sum[2]) & sum[63])) ^ ((sum[2] & (~sum[2] & sum[63])) | ((((sum[63] | sum[2]) & (~sum[63] | sum[63])) & ~sum[63]) & sum[2]))) | (((~sum[63] | (~sum[2] & sum[63])) & ((~sum[2] | sum[2]) & sum[63])) ^ ((sum[2] & (~sum[2] & sum[63])) | ((((sum[63] | sum[2]) & (~sum[63] | sum[63])) & ~sum[63]) & sum[2]))))) ^ (((~sum[63] | (~sum[2] & sum[63])) & ((~sum[2] | sum[2]) & sum[63])) ^ ((sum[2] & (~sum[2] & sum[63])) | ((((sum[63] | sum[2]) & (~sum[63] | sum[63])) & ~sum[63]) & sum[2])))} | ~result))) ^ ((~{sum[62:0],(sum[0] & (~(((~sum[63] | (~sum[2] & sum[63])) & ((~sum[2] | sum[2]) & sum[63])) ^ ((sum[2] & (~sum[2] & sum[63])) | ((((sum[63] | sum[2]) & (~sum[63] | sum[63])) & ~sum[63]) & sum[2]))) | (((~sum[63] | (~sum[2] & sum[63])) & ((~sum[2] | sum[2]) & sum[63])) ^ ((sum[2] & (~sum[2] & sum[63])) | ((((sum[63] | sum[2]) & (~sum[63] | sum[63])) & ~sum[63]) & sum[2]))))) ^ (((~sum[63] | (~sum[2] & sum[63])) & ((~sum[2] | sum[2]) & sum[63])) ^ ((sum[2] & (~sum[2] & sum[63])) | ((((sum[63] | sum[2]) & (~sum[63] | sum[63])) & ~sum[63]) & sum[2])))} | ~result) & ((~{sum[62:0],(sum[0] & (~(((~sum[63] | (~sum[2] & sum[63])) & ((~sum[2] | sum[2]) & sum[63])) ^ ((sum[2] & (~sum[2] & sum[63])) | ((((sum[63] | sum[2]) & (~sum[63] | sum[63])) & ~sum[63]) & sum[2]))) | (((~sum[63] | (~sum[2] & sum[63])) & ((~sum[2] | sum[2]) & sum[63])) ^ ((sum[2] & (~sum[2] & sum[63])) | ((((sum[63] | sum[2]) & (~sum[63] | sum[63])) & ~sum[63]) & sum[2]))))) ^ (((~sum[63] | (~sum[2] & sum[63])) & ((~sum[2] | sum[2]) & sum[63])) ^ ((sum[2] & (~sum[2] & sum[63])) | ((((sum[63] | sum[2]) & (~sum[63] | sum[63])) & ~sum[63]) & sum[2])))} & {sum[62:0],(sum[0] & (~(((~sum[63] | (~sum[2] & sum[63])) & ((~sum[2] | sum[2]) & sum[63])) ^ ((sum[2] & (~sum[2] & sum[63])) | ((((sum[63] | sum[2]) & (~sum[63] | sum[63])) & ~sum[63]) & sum[2]))) | (((~sum[63] | (~sum[2] & sum[63])) & ((~sum[2] | sum[2]) & sum[63])) ^ ((sum[2] & (~sum[2] & sum[63])) | ((((sum[63] | sum[2]) & (~sum[63] | sum[63])) & ~sum[63]) & sum[2]))))) ^ (((~sum[63] | (~sum[2] & sum[63])) & ((~sum[2] | sum[2]) & sum[63])) ^ ((sum[2] & (~sum[2] & sum[63])) | ((((sum[63] | sum[2]) & (~sum[63] | sum[63])) & ~sum[63]) & sum[2])))}) | (({sum[62:0],(sum[0] & (~(((~sum[63] | (~sum[2] & sum[63])) & ((~sum[2] | sum[2]) & sum[63])) ^ ((sum[2] & (~sum[2] & sum[63])) | ((((sum[63] | sum[2]) & (~sum[63] | sum[63])) & ~sum[63]) & sum[2]))) | (((~sum[63] | (~sum[2] & sum[63])) & ((~sum[2] | sum[2]) & sum[63])) ^ ((sum[2] & (~sum[2] & sum[63])) | ((((sum[63] | sum[2]) & (~sum[63] | sum[63])) & ~sum[63]) & sum[2]))))) ^ (((~sum[63] | (~sum[2] & sum[63])) & ((~sum[2] | sum[2]) & sum[63])) ^ ((sum[2] & (~sum[2] & sum[63])) | ((((sum[63] | sum[2]) & (~sum[63] | sum[63])) & ~sum[63]) & sum[2])))} & ((~result | result) & (result | {sum[62:0],(sum[0] & (~(((~sum[63] | (~sum[2] & sum[63])) & ((~sum[2] | sum[2]) & sum[63])) ^ ((sum[2] & (~sum[2] & sum[63])) | ((((sum[63] | sum[2]) & (~sum[63] | sum[63])) & ~sum[63]) & sum[2]))) | (((~sum[63] | (~sum[2] & sum[63])) & ((~sum[2] | sum[2]) & sum[63])) ^ ((sum[2] & (~sum[2] & sum[63])) | ((((sum[63] | sum[2]) & (~sum[63] | sum[63])) & ~sum[63]) & sum[2]))))) ^ (((~sum[63] | (~sum[2] & sum[63])) & ((~sum[2] | sum[2]) & sum[63])) ^ ((sum[2] & (~sum[2] & sum[63])) | ((((sum[63] | sum[2]) & (~sum[63] | sum[63])) & ~sum[63]) & sum[2])))}))) & ~result)));
        if (cyc == 0) 
          begin
            crc <= 64'h5aef0c8d_d70a4497;
            sum <= 64'h0;
          end
        else if (cyc < 10) 
          begin
            sum <= 64'h0;
          end
        else if (cyc < 90) 
          begin

          end
        else if (cyc == 99) 
          begin
            $write("[%0t] cyc==%0d crc=%x sum=%x\n",$time,cyc,crc,sum);
            if (crc !== 64'hc77bb9b3784ea091) 
              $stop;
              
            if (sum !== 64'h056ea1c5a63aff6a) 
              $stop;
              
            $write("*-* All Finished *-*\n");
            $finish;
          end
          
      end
endmodule

