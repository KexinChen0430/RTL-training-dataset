
module eight_bit_counter(count_out,enable,clock,clear);

  eight_bit_counter s1(count_out,enable,clock,clear);
  
  initial  
  begin
    $monitor("At time",$time,
             " clear = %b, enable = %b, and count = %h\n",clear,enable,count_out);
    #2700 $finish;
  end
  
  initial  
  begin
    clear = 0;
    enable = 0;
    #10 clear = 1;
    #20 enable = 1;
    #2600 clear = 0;
  end
  
  initial    clock = 1'b0;
  
  always   #5 clock = ~clock;
endmodule

