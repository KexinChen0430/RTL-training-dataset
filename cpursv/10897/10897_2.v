
module ledctr(input  clk,
              input  ce,
              output ledalive);

  reg  [9:0]  counter = 0;

  assign ledalive = counter[9];
  
  always @(posedge clk)
      begin
        if (ce) counter <= 1+counter;
          
      end
endmodule

