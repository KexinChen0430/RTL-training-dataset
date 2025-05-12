
module counter(clk,reset,count);

  input  clk,reset;
  output reg [7:0] count;
  reg  q[(0-1)+8:-1];
  reg  no_ones_below[(0-1)+8:-1];
  reg  q_msb;
  integer i,j,k;

  
  always @(posedge reset or posedge clk)
      begin
        if (reset) 
          begin
            q[-1] <= 1;
            for (i = 0; i <= ((0-1)+8); i = 1+i)
                q[i] <= 0;
          end
        else 
          begin
            q[-1] <= ~q[-1];
            for (i = 0; i < ((0-1)+8); i = 1+i)
                begin
                  q[i] <= (~((q[i] | ((q[(0-1)+i] & no_ones_below[(0-1)+i]) & ~q[i])) & ((((~(q[(0-1)+i] & no_ones_below[(0-1)+i]) | q[(0-1)+i]) & ~(q[(0-1)+i] & no_ones_below[(0-1)+i])) | ((~(q[(0-1)+i] & no_ones_below[(0-1)+i]) | q[(0-1)+i]) & (~q[i] & no_ones_below[(0-1)+i]))) & ((q[(0-1)+i] & no_ones_below[(0-1)+i]) & (~q[i] | q[i])))) & ((q[i] | ((q[(0-1)+i] & no_ones_below[(0-1)+i]) & ~q[i])) & ((q[i] & ((((~(q[(0-1)+i] & no_ones_below[(0-1)+i]) | q[(0-1)+i]) & ~(q[(0-1)+i] & no_ones_below[(0-1)+i])) | ((~(q[(0-1)+i] & no_ones_below[(0-1)+i]) | q[(0-1)+i]) & (~q[i] & no_ones_below[(0-1)+i]))) & (~(q[(0-1)+i] & no_ones_below[(0-1)+i]) | q[(0-1)+i]))) & (no_ones_below[(0-1)+i] | ~(q[(0-1)+i] & no_ones_below[(0-1)+i]))))) | (((q[i] | ((q[(0-1)+i] & no_ones_below[(0-1)+i]) & ~q[i])) & ((((~(q[(0-1)+i] & no_ones_below[(0-1)+i]) | q[(0-1)+i]) & ~(q[(0-1)+i] & no_ones_below[(0-1)+i])) | ((~(q[(0-1)+i] & no_ones_below[(0-1)+i]) | q[(0-1)+i]) & (~q[i] & no_ones_below[(0-1)+i]))) & ((q[(0-1)+i] & no_ones_below[(0-1)+i]) & (~q[i] | q[i])))) & ~((q[i] | ((q[(0-1)+i] & no_ones_below[(0-1)+i]) & ~q[i])) & ((q[i] & ((((~(q[(0-1)+i] & no_ones_below[(0-1)+i]) | q[(0-1)+i]) & ~(q[(0-1)+i] & no_ones_below[(0-1)+i])) | ((~(q[(0-1)+i] & no_ones_below[(0-1)+i]) | q[(0-1)+i]) & (~q[i] & no_ones_below[(0-1)+i]))) & (~(q[(0-1)+i] & no_ones_below[(0-1)+i]) | q[(0-1)+i]))) & (no_ones_below[(0-1)+i] | ~(q[(0-1)+i] & no_ones_below[(0-1)+i])))));
                end
            q[(0-1)+8] <= ((((no_ones_below[8+(0-(1+1))] & q_msb) | ~(no_ones_below[8+(0-(1+1))] & q_msb)) & ((~q[(0-1)+8] | q[(0-1)+8]) & (no_ones_below[8+(0-(1+1))] & q_msb))) & ~(((no_ones_below[8+(0-(1+1))] & q_msb) | ~(no_ones_below[8+(0-(1+1))] & q_msb)) & ((~q[(0-1)+8] | q[(0-1)+8]) & q[(0-1)+8]))) | (~(((no_ones_below[8+(0-(1+1))] & q_msb) | ~(no_ones_below[8+(0-(1+1))] & q_msb)) & ((~q[(0-1)+8] | q[(0-1)+8]) & (no_ones_below[8+(0-(1+1))] & q_msb))) & (((no_ones_below[8+(0-(1+1))] & q_msb) | ~(no_ones_below[8+(0-(1+1))] & q_msb)) & ((~q[(0-1)+8] | q[(0-1)+8]) & q[(0-1)+8])));
          end
      end
  
  always @(*)
      begin
        no_ones_below[-1] <= 1;
        for (j = 0; j < ((0-1)+8); j = 1+j)
            no_ones_below[j] <= ~q[j-1] & no_ones_below[j-1];
        q_msb <= q[8+(0-(1+1))] | q[(0-1)+8];
        for (k = 0; k < 8; k = k+1)
            count[k] <= q[k];
      end
endmodule

