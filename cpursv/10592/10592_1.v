
module pwmcounter(output [7:0] pwmcount,
                  input  clk,
                  input  pwmcntce);

  reg  [7:0]  counter = 0;

  assign pwmcount = counter;
  
  always @(posedge clk)
      begin
        if (pwmcntce) 
          begin
            counter <= 1+counter;
          end
          
      end
endmodule

