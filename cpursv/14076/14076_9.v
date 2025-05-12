
module test;

  reg  [4:0] foo40;
  reg  [0:4] foo04;
  reg  [5:1] foo51;
  reg  [1:5] foo15;

  
  initial  
  begin
    #102 ;
    $finish;
  end
  
  initial    #1 begin
    foo40 = 0;
    foo04 = 0;
    foo51 = 0;
    foo15 = 0;
  end
  
  always 
      #10 begin
        foo40 <= 1+foo40;
        foo04 <= foo04+1;
        foo51 <= 1+foo51;
        foo15 <= foo15+1;
      end
  
  always @(foo40)
      begin
        $write("foo40=%8d\n",foo40);
      end
  
  always @(foo04)
      begin
        $write("               foo04=%8d\n",foo04);
      end
  
  always @(foo51)
      begin
        $write("                              foo51=%8d\n",foo51);
      end
  
  always @(foo15)
      begin
        $write("                                             foo15=%8d\n",
               foo15);
      end
endmodule

