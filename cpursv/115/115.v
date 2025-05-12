
module at_the_start;

  reg  clk;

  
  always 
      begin
        #10 clk = 0;
        #10 clk = 1;
      end
  reg  reset;

  reg  [13:0] b,e;

  reg  [13:0] r_b,r_e;

  reg  [13:0] r_c,rr_e,rr_b;

  reg  [13:0] rb,r_qx,e2;

  reg  [13:0] c,cx;

  wire [13:0] q;

  
  always @(posedge clk)
      begin
        if (reset) 
          begin
            r_b <= 0;
            r_e <= 0;
          end
        else 
          begin
            r_e <= e;
            r_b <= b;
          end
      end
  
  always @(posedge clk)
      begin
        if (reset) 
          begin
            r_c <= 0;
            rr_e <= 0;
            rr_b <= 0;
          end
        else 
          begin
            r_c <= c;
            rr_e <= r_e;
            rr_b <= r_b;
          end
      end
  
  always @(posedge clk)
      begin
        if (reset) 
          begin
            rb <= 0;
          end
        else 
          begin
            r_qx <= cx;
            rb <= rr_b;
            e2 <= rr_e;
          end
      end
  
  initial  
  begin
    $display(" << Starting the simulation >>");
    reset = 1;
    #20 ;
    reset = 0;
  end
endmodule

