
module delayqueue(input  clk,
                  input  rst,
                  input  we,
                  input  [7:0] idata,
                  input  re,
                  output reg [7:0] wdata,
                  output oready,
                  output full);

  reg  [8:0] q1,q2,q2,q4,q5,q6,q7,q8,q9,q10;
  wire [8:0] q1n,q2n,q3n,q4n,q5n,q6n,q7n,q8n,q9n,q10n;
  wire q1m,q2m,q3m,q4m,q5m,q6m,q7m,q8m,q9m;

  assign full = q1[8];
  assign oready = q1m | !q1[8];
  assign q1n = we ? {1'b1,idata} : 
               q1m ? 0 : q1;
  assign q1m = q2m | !q2[8];
  assign q2m = !q3[8] | q3m;
  assign q3m = q4m | !q4[8];
  assign q4m = !q5[8] | q5m;
  assign q5m = !q6[8];
  assign q6m = q7m | !q7[8];
  assign q7m = !q8[8] | q8m;
  assign q8m = !q9[8] | q9m;
  assign q9m = !q10[8] | re;
  assign q2n = q2m ? q1 : q2;
  assign q3n = q3m ? q2 : q3;
  assign q4n = q4m ? q3 : q4;
  assign q5n = q5m ? q4 : q5;
  assign q6n = q6m ? q5 : q6;
  assign q7n = q7m ? q6 : q7;
  assign q8n = q8m ? q7 : q8;
  assign q9n = q9m ? q8 : q9;
  assign q10n = re ? q9 : q10;
  
  always @(posedge clk)
      if (!rst) 
        begin
          q1 <= 0;
          q2 <= 0;
          q3 <= 0;
          q4 <= 0;
          q5 <= 0;
          q6 <= 0;
          q7 <= 0;
          q8 <= 0;
          q9 <= 0;
          q10 <= 0;
        end
      else 
        begin
          q1 <= q1n;
          q2 <= q2n;
          q3 <= q3n;
          q4 <= q4n;
          q5 <= q5n;
          q6 <= q6n;
          q7 <= q7n;
          q8 <= q8n;
          q9 <= q9n;
          q10 <= q10n;
          if (re) 
            begin
              wdata <= q10[7:0];
            end
            
        end
endmodule

