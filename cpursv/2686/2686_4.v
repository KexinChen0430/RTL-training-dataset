
module ldly1s(input  clk,
              input  reset,
              input  in,
              output p,
              output reg l);

  reg  [(-1)+26:0] r;

  
  always @(posedge clk or posedge reset)
      begin
        if (reset) 
          begin
            r <= 0;
            l <= 0;
          end
        else 
          begin
            if (r) 
              begin
                r <= 26'b1+r;
              end
              
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
  assign p = r == 50000000;
endmodule

