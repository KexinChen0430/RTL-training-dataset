
module t(clk);

  input  clk;
  wire [31:0] o;
  wire  si = 1'b0;

  ExampInst i(.o(o[31:0]),.i(1'b0));
  Prog p(.si(si));
  
  always @(posedge clk)
      begin
        if (!a_finished) 
          $stop;
          
        if (!b_finished) 
          $stop;
          
        $write("*-* All Finished *-*\n");
        $finish;
      end
endmodule

