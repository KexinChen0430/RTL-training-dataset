
module gen_test2(clk,a,b,y);

  input  clk;
  input  [7:0] a,b;
  output reg [8:0] y;
  integer i;
  reg  [8:0] carry;

  
  always @(posedge clk)
      begin
        carry[0] = 0;
        for (i = 0; i < 8; i = 1+i)
            begin
              casez ({a[i],b[i],carry[i]})

                3'b?11,3'b1?1,3'b11?: carry[1+i] = 1;

                default: carry[1+i] = 0;

              endcase

              y[i] = (((~a[i] & ~carry[i]) | (~((~b[i] & (((a[i] & ~b[i]) | a[i]) | (b[i] & ~a[i]))) | (b[i] & ~a[i])) & carry[i])) & (b[i] | (~((~b[i] & (((a[i] & ~b[i]) | a[i]) | (b[i] & ~a[i]))) | (b[i] & ~a[i])) & carry[i]))) | ((~carry[i] | ~((~b[i] & (((a[i] & ~b[i]) | a[i]) | (b[i] & ~a[i]))) | (b[i] & ~a[i]))) & (a[i] & ~b[i]));
            end
        y[8] = carry[8];
      end
endmodule

