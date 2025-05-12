
module main;

  reg  one,clk;
  reg  [1:0] a,b,c,passed;
  reg  [7:0] count;

  
  always   #1 one = ~one;
  
  always   #10 clk = ~clk;
  
  initial  
  begin
    $display("\n<< BEGIN >>");
    one = 1'b1;
    clk = 1'b0;
    passed = 2'b00;
    count = 0;
    #15 a[1:0] = 2'b01;
    #10 a[1:0] = 2'b10;
    #20 $display("\n<< END  >>");
    if (passed == 2) 
      $display(PASSED);
    else 
      $display(FAILED);
    $finish;
  end
  
  always @(clk)
      begin
        b[1:0] <= #2.5 a[1:0];
        c[1:0] <= #7.8 a[1:0];
      end
  
  always @(one)  count[7:0] <= count+1;
  
  always @(count)
      begin
        case (count)

          'd25: if (b[1:0] == 2'b01) 
                begin
                  $display("@ %0t - Got ONE",$time);
                  passed = passed+1;
                end
              else 
                $display("@ %0t - failure",$time);

          'd29: if (b[1:0] == 2'b01) 
                begin
                  $display("@ %0t - Got ONE",$time);
                  passed = passed+1;
                end
              else 
                $display("@ %0t - failure",$time);

          default: $display("@ %0t - no count",$time);

        endcase

      end
endmodule

