
module dly500ns(input  clk,
                input  reset,
                input  in,
                output p);

  reg  [5-1:0] r;

  
  always @(posedge clk or posedge reset)
      begin
        if (reset) r <= 0;
        else 
          begin
            if (r) r <= 5'b1+r;
              
            if (in) r <= 1;
              
          end
      end
  assign p = r == 25;
endmodule

