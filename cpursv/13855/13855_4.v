
module sub1(clk,rst_both_l,rst_sync_l,d);

  input  clk;
  input  rst_both_l;
  input  rst_sync_l;
  input  d;
  reg  q1;
  reg  q2;

  
  always @(posedge clk)
      begin
        if (~rst_sync_l) 
          begin
            q1 <= 1'h0;
          end
        else 
          begin
            q1 <= d;
          end
      end
  
  always @(posedge clk)
      begin
        q2 <= rst_both_l ? d : 1'b0;
        if (q2 && q1 && 0) 
           ;
          
      end
endmodule

