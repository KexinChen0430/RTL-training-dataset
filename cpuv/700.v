module t (
   clk
   );
   input clk;
   integer cyc = 0;
   reg [63:0] crc;
   reg [63:0] sum;
   wire [3:0] a = crc[3:0];   
   wire [3:0] b = crc[19:16]; 
   wire [3:0] out1 = {a,b}[2 +: 4]; 
   wire [3:0] out2 = {a,b}[5 -: 4]; 
   wire [3:0] out3 = {a,b}[5 : 2];  
   wire [0:0] out4 = {a,b}[2];      
   wire [63:0] result = {51'h0, out4, out3, out2, out1};
   always @ (posedge clk) begin
`ifdef TEST_VERBOSE
      $write("[%0t] cyc==%0d crc=%x result=%x\n", $time, cyc, crc, result);
`endif
      cyc <= cyc + 1;
      crc <= {crc[62:0], crc[63]^crc[2]^crc[0]};
      sum <= result ^ {sum[62:0], sum[63]^sum[2]^sum[0]};
      if (cyc == 0) begin
         crc <= 64'h5aef0c8d_d70a4497;
         sum <= '0;
      end
      else if (cyc < 10) begin
         sum <= '0;
      end
      else if (cyc < 90) begin
      end
      else if (cyc == 99) begin
         $write("[%0t] cyc==%0d crc=%x sum=%x\n", $time, cyc, crc, sum);
         if (crc !== 64'hc77bb9b3784ea091) $stop;
`define EXPECTED_SUM 64'h4afe43fb79d7b71e
         if (sum !== `EXPECTED_SUM) $stop;
         $write("*-* All Finished *-*\n");
         $finish;
      end
   end
endmodule