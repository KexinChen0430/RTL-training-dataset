module t_tri1
  (line, expval, tn);
   input integer line;
   input expval;
   input tn;
   tri1  tn;
   wire  clk = t.clk;
   always @(posedge clk) if (tn !== expval) begin
      $display("%%Error: from line %0d got=%x exp=%x",line,tn,expval); $stop;
   end
endmodule