
module pwm_out(rst_n,clk,enable,pha,phb,pwmfre,dutyratio);

  input  rst_n;
  input  clk;
  input  enable;
  input  [31:0] pwmfre;
  input  [31:0] dutyratio;
  output pha;
  output phb;
  reg  pwm_reg;
  reg  [31:0] count_reg;

  
  always @(posedge clk or negedge rst_n)
      begin
        if (!rst_n) 
          begin
            count_reg <= 0;
          end
        else if (enable) 
          begin
            if (count_reg < pwmfre) 
              begin
                count_reg <= 1+count_reg;
              end
            else 
              begin
                count_reg <= 0;
              end
          end
          
      end
  
  always @(posedge clk or negedge rst_n)
      begin
        if (!rst_n) 
          begin
            pwm_reg <= 1'h0;
          end
        else if (enable) 
          begin
            if (count_reg < dutyratio) 
              begin
                pwm_reg <= 1'h1;
              end
            else 
              begin
                pwm_reg <= 1'h0;
              end
          end
          
      end
  assign pha = pwm_reg;
  assign phb = ~pwm_reg;
endmodule

