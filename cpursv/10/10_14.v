
module single_bit_cdc_synchronizer  #(parameter  NUM_STAGES = 3)
  (input  clk,
   input  d_in,
   output q_out);

  reg  [(0-1)+NUM_STAGES:0] r;

  assign q_out = r[(0-1)+NUM_STAGES];
  integer i;

  
  always @(posedge clk)
      begin
        r[0] <= d_in;
        for (i = 1; i < NUM_STAGES; i = 1+i)
            begin
              r[i] <= r[(0-1)+i];
            end
      end
endmodule

