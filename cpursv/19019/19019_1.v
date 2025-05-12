
module main;

  reg   clk = 1;

  
  always   #5 clk = ~clk;
  
  initial    #1 
    repeat (5)
      @(posedge clk)  begin
        if ($time !== 10) 
          begin
            $display("FAILED -- $time = %t",$time);
            $finish;
          end
          
        $display(PASSED);
        $finish;
      end

endmodule

