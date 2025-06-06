
module bd2(input  clk,
           input  reset,
           input  in,
           output p);

  reg  [2:0] r;

  
  always @(posedge clk or posedge reset)
      begin
        if (reset) r <= 0;
        else 
          begin
            if (r) r <= 3'b1+r;
              
            if (in) r <= 1;
              
          end
      end
  assign p = (r == 5) || (r == 4) || ((r == 3) || (r == 2));
endmodule

