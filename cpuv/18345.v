module t (
   clk
   );
   input clk; 
   integer      cyc = 0;
   reg [63:0]   crc;
   reg [63:0]   sum;
   int A [7][1], B [8][1];
   int a    [1], b    [1];
   always_ff @(posedge clk) begin
      a <= A[crc[2:0]];
      b <= B[crc[2:0]];
   end
   wire [63:0] result = {a[0], b[0]};
   always @ (posedge clk) begin
`ifdef TEST_VERBOSE
      $write("[%0t] cyc==%0d crc=%x result=%x\n", $time, cyc, crc, result);
`endif
      cyc <= cyc + 1;
      crc <= {crc[62:0], crc[63] ^ crc[2] ^ crc[0]};
      sum <= result ^ {sum[62:0], sum[63] ^ sum[2] ^ sum[0]};
      if (cyc==0) begin
         crc <= 64'h5aef0c8d_d70a4497;
         sum <= '0;
         A[0][0] <= 32'h1_0;
         A[1][0] <= 32'h1_1;
         B[7][0] <= 32'h2_7;
      end
      else if (cyc<10) begin
         sum <= '0;
      end
      else if (cyc<90) begin
      end
      else if (cyc==99) begin
         $write("[%0t] cyc==%0d crc=%x sum=%x\n", $time, cyc, crc, sum);
         if (crc !== 64'hc77bb9b3784ea091) $stop;
`define EXPECTED_SUM 64'h619f75c3a6d948bd
         if (sum !== `EXPECTED_SUM) $stop;
         $write("*-* All Finished *-*\n");
         $finish;
      end
   end
endmodule