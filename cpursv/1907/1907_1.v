
module shift_check(input  clk,
                   input  rst,
                   input  LOCKED,
                   input  [31:0] desired_shift_1000,
                   input  [31:0] clk_period_1000,
                   input  [31:0] clk_shifted,
                   output reg fail);

  
  always @(posedge clk or posedge rst)
      begin
        if (rst) 
          begin
            fail <= 0;
          end
        else if (LOCKED) 
          begin
            if (desired_shift_1000 > 0) 
              begin
                if (clk_shifted !== 0) 
                  begin
                    fail <= 1;
                  end
                  
              end
            else if (desired_shift_1000 < 0) 
              begin
                if (clk_shifted !== 0) 
                  begin
                    fail <= 1;
                  end
                  
              end
              
            if ((clk_shifted !== 1) && (desired_shift_1000 !== 0)) 
              begin
                fail <= 1;
              end
              
          end
          
      end
endmodule

