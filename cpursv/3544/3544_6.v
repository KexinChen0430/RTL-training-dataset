
module ldly5s(input  clk,
              input  reset,
              input  in,
              output p,
              output reg l);

  reg  [28+(-1):0] r;

  
  always @(posedge clk or posedge reset)
      begin
        if (reset) 
          begin
            r <= 0;
            l <= 0;
          end
        else 
          begin
            if (r) r <= r+28'b1;
              
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
  assign p = r == 250000000;
endmodule

