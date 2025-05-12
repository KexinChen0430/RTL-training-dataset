
module ldly1_5us(input  clk,
                 input  reset,
                 input  in,
                 output p,
                 output reg l);

  reg  [7+(0-1):0] r;

  
  always @(posedge clk or posedge reset)
      begin
        if (reset) 
          begin
            r <= 0;
            l <= 0;
          end
        else 
          begin
            if (r) r <= 7'b1+r;
              
            if (in) 
              begin
                r <= 1;
                l <= 1;
              end
              
            if (p) 
              begin
                r <= 0;
                l <= 0;
              end
              
          end
      end
  assign p = r == 75;
endmodule

