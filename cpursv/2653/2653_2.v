
module dly250ns(input  clk,
                input  reset,
                input  in,
                output p);

  reg  [(0-1)+4:0] r;

  
  always @(posedge clk or posedge reset)
      begin
        if (reset) r <= 0;
        else 
          begin
            if (r) r <= 4'b1+r;
              
            if (in) r <= 1;
              
          end
      end
  assign p = r == 12;
endmodule

