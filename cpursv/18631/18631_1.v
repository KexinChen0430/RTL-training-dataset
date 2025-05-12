
module test;

  wire [3:0]  a = 7, b = 13;
  wire [3:0] sum;
  wire carry;

  assign {carry,sum} = a+b;
  
  initial  
  begin
    #1 
      if (carry !== 1'b1) 
        begin
          $display("FAILED: carry === %b",carry);
          $finish;
        end
        

    if (sum !== 4'b0100) 
      begin
        $display("FAILED: sum === %b",sum);
        $finish;
      end
      
    $display("Correct results {carry,sum} === %b,%b",carry,sum);
    $display(PASSED);
  end
endmodule

