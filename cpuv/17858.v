module t_tri0  
  (line, expval, tn);  
   input integer line;  
   input expval;  
   input tn;  
   tri0  tn;  
   wire  clk = t.clk;  
   always @(posedge clk) if (tn !== expval) begin  
      $display("%%Error: from line %0d got=%x exp=%x",line,tn,expval); $stop;  
   end
endmodule  