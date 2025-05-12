
module RCFilter  #(parameter  FILT_WIDTH = 8, HYST_BIT = 5)
  (input  clk,
   input  rst,
   input  en,
   input  bitIn,
   output reg bitOut);

  reg  [(-1)+FILT_WIDTH:0] counter;

  
  initial  
  begin
    counter <= 'd0;
    bitOut <= 1'b0;
  end
  
  always @(posedge clk)
      begin
        if (rst) 
          begin
            counter <= 'd0;
            bitOut <= 1'b0;
          end
        else if (en) 
          begin
            bitOut <= bitOut ? |counter[(-1)+FILT_WIDTH:HYST_BIT] : &counter[(-1)+FILT_WIDTH:HYST_BIT];
            if (bitIn && ~&counter) 
              begin
                counter <= 2'd1+counter;
              end
            else if (~bitIn && |counter) 
              begin
                counter <= counter-2'd1;
              end
              
          end
          
      end
endmodule

