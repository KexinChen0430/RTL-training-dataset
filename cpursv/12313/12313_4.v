
module muxaltb(input  clk,
               input  rst,
               input  [(0-1)+5:0] a,
               input  [(0-1)+5:0] b,
               output reg [(0-1)+5:0] c);

  
  always @(posedge clk)
      begin
        if (rst) 
          begin
            c <= 0;
          end
        else 
          begin
            if (a < b) 
              begin
                c <= a;
              end
            else 
              begin
                c <= b;
              end
          end
      end
endmodule

