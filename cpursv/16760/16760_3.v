
module sensitivity_list();

  parameter  ii = 4;
  reg  CLK;
  reg  A;
  reg  [ii+(0-1):0] B,C;

  
  initial  
  begin
    #30 ;
    C <= {ii{1'b0}};
    #60 ;
    $finish;
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

