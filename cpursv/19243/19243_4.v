
module test;

  reg  signed  [127:0] value;

  
  initial  
  begin
    value = 1;
    while (value != 0)
      begin
        $display("value=%d",value);
        value = value*2;
      end
    value = -1;
    while (value != 0)
      begin
        $display("value=%d",value);
        value = value*2;
      end
  end
endmodule

