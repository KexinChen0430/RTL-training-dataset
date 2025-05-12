module prop_parens;
   LABEL: cover property (
      @(posedge clk)
      (
         (foo[3:0] == 4'h0)
         & 
         bar
      )
   );
endmodule