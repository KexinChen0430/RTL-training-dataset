
module sensitivity_list();

  parameter  ii = 4;
  reg  CLK;
  reg  A;
  reg  [(-1)+ii:0] B,C;

  
  initial  
  begin
    #30 ;
    C <= {ii{1'b0}};
    #60 ;
    $finish(0);
  end
  
  always 
      begin
        CLK = 1'b0;
        #10 ;
        CLK = 1'b1;
        #10 ;
        $display($time);
      end
  
  always @(A or C)
      begin
        A = 1'b0;
        $display("combinatorial process ",A," time:",$time);
        A = 1'b1;
        $display("combinatorial process ",A," time:",$time);
        B = A+C;
      end
endmodule

