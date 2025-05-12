
module single_bit_cdc_synchronizer  #(parameter  NUM_STAGES = 3)
  (input  clk,
   input  d_in,
   output q_out);

  reg  [NUM_STAGES-1:0] r;

  assign q_out = r[NUM_STAGES-1];
  integer i;

  
  always @(posedge clk)
      begin
        r[0] <= d_in;
        for (i = 1; i < NUM_STAGES; i = i+1)
            begin
              r[i] <= r[i+(-1)];
            end
      end
endmodule

