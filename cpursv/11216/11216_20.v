
module counter(clk,reset,count);

  input  clk,reset;
  output reg [7:0] count;
  reg  q[8+(0-1):-1];
  reg  no_ones_below[8+(0-1):-1];
  reg  q_msb;
  integer i,j,k;

  
  always @(posedge reset or posedge clk)
      begin
        if (reset) 
          begin
            q[-1] <= 1;
            for (i = 0; i <= (8+(0-1)); i = 1+i)
                q[i] <= 0;
          end
        else 
          begin
            q[-1] <= ~q[-1];
            for (i = 0; i < (8+(0-1)); i = 1+i)
                begin
                  q[i] <= ((((((~q[i] | q[i]) & (no_ones_below[i-1] & q[i-1])) & ~q[i]) | (((~q[i] | q[i]) & (no_ones_below[i-1] & q[i-1])) & ~(no_ones_below[i-1] & q[i-1]))) | ~q[i]) | ~(no_ones_below[i-1] & q[i-1])) & (((~q[i] & q[i-1]) | q[i]) & (no_ones_below[i-1] | q[i]));
                end
            q[8+(0-1)] <= ((~q[8+(0-1)] & no_ones_below[8-(1+1)]) & (q_msb & (((q[8+(0-1)] | no_ones_below[8-(1+1)]) & (q[8+(0-1)] | ~q[8+(0-1)])) & (q[8+(0-1)] | q_msb)))) | ((q[8+(0-1)] & ((no_ones_below[8-(1+1)] | ~(q_msb & no_ones_below[8-(1+1)])) & (~(q_msb & no_ones_below[8-(1+1)]) | q_msb))) & (~(q_msb & no_ones_below[8-(1+1)]) | ((q[8+(0-1)] | ~q[8+(0-1)]) & ((~q[8+(0-1)] & no_ones_below[8-(1+1)]) & (q_msb & (((q[8+(0-1)] | no_ones_below[8-(1+1)]) & (q[8+(0-1)] | ~q[8+(0-1)])) & (q[8+(0-1)] | q_msb)))))));
          end
      end
  
  always @(*)
      begin
        no_ones_below[-1] <= 1;
        for (j = 0; j < (8+(0-1)); j = j+1)
            no_ones_below[j] <= no_ones_below[(0-1)+j] & ~q[(0-1)+j];
        q_msb <= q[8-(1+1)] | q[8+(0-1)];
        for (k = 0; k < 8; k = k+1)
            count[k] <= q[k];
      end
endmodule

