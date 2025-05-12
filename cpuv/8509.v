module Test( output logic o,
             input 	 rc_t rc,
             input logic clk);
   localparam RATIO = 2;
   rc_t rc_d[RATIO:1];
   always_ff @(posedge clk) begin
      integer  k;
      rc_d[1] <= rc;
      for( k=2; k<RATIO+1; k++ ) begin
         rc_d[k] <= rc_d[k-1];
      end
   end 
   assign o = rc_d[RATIO] < 0;
endmodule