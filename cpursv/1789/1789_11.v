
module hybrid_pwm_sd(input  clk,
                     input  n_reset,
                     input  [15:0] din,
                     output dout);

  reg  [4:0] pwmcounter;
  reg  [4:0] pwmthreshold;
  reg  [33:0] scaledin;
  reg  [15:0] sigma;
  reg  out;

  assign dout = out;
  
  always @(posedge clk or negedge n_reset)
      begin
        if (!n_reset) 
          begin
            sigma <= 16'b00000100_00000000;
            pwmthreshold <= 5'b10000;
            pwmcounter <= 5'd0;
            scaledin <= 34'd0;
          end
        else 
          begin
            pwmcounter <= 1+pwmcounter;
            if (pwmcounter == pwmthreshold) out <= 1'b0;
              
            if (pwmcounter == 5'b11111) 
              begin
                scaledin <= (61440*{1'b0,din})+33'd134217728;
                sigma <= {5'b000000,sigma[10:0]}+scaledin[31:16];
                pwmthreshold <= sigma[15:11];
                out <= 1'b1;
              end
              
          end
      end
endmodule

