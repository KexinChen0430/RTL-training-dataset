
module dly750ns(input  clk,
                input  reset,
                input  in,
                output p);

  reg  [(-1)+6:0] r;

  
  always @(posedge clk or posedge reset)
      begin
        if (reset) r <= 0;
        else 
          begin
            if (r) r <= r+6'b1;
              
            if (in) r <= 1;
              
          end
      end
  assign p = r == 37;
endmodule

