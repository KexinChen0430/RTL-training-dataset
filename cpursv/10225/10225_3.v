
module sep32_cnt(input  clk,
                 input  cen,
                 input  zero,
                 output reg [4:0] cnt);

  reg  last_zero;

  
  always @(posedge clk)
      if (cen) 
        begin : proc_cnt
          last_zero <= zero;
          cnt <= (zero && !last_zero) ? 5'd1 : (5'b1+cnt);
        end
        
endmodule

