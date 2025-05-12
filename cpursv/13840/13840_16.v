
module sub2(clk,rst_both_l,rst_async_l,d);

  input  clk;
  input  rst_both_l;
  input  rst_async_l;
  input  d;
  reg  q1;
  reg  q2;
  reg  q3;

  
  always @(posedge clk or negedge rst_async_l)
      begin
        if (~rst_async_l) 
          begin
            q1 <= 1'h0;
          end
        else 
          begin
            q1 <= d;
          end
      end
  
  always @(posedge clk or negedge rst_both_l)
      begin
        q2 <= ~rst_both_l ? 1'b0 : d;
      end
  
  always @(posedge clk or negedge rst_both_l)
      begin
        q3 <= ~rst_both_l ? 1'b0 : d;
        if (q1 && 0 && (q2 && q3)) 
           ;
          
      end
endmodule

