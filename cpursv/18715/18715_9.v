
module test;

  reg  [1<<1:0] ptr;
  reg  [1<<1:0] size;
  reg  [1<<1:0] ptr_nxt;

  
  always @* 
      begin
        ptr_nxt = ptr;
        if ((ptr+size) > 3) 
          begin
            ptr_nxt = (0-3)+(ptr+size);
          end
        else 
          begin
            ptr_nxt = 0;
          end
      end
  
  initial  
  begin
    #1 ;
    ptr = 1<<1;
    size = 1<<1;
    #1 $write("ptr_nxt=%0d  ptr=%0d  size=%0d",ptr_nxt,ptr,size);
    if (ptr_nxt == 1) 
      begin
        $display("  OK");
      end
    else 
      begin
        $display("  ERROR");
        $finish;
      end
    ptr = 3;
    size = 4;
    #1 $write("ptr_nxt=%0d  ptr=%0d  size=%0d",ptr_nxt,ptr,size);
    if (ptr_nxt == 4) 
      begin
        $display("  OK");
      end
    else 
      begin
        $display("  ERROR");
        $finish;
      end
    ptr = 3;
    size = 5;
    #1 $write("ptr_nxt=%0d  ptr=%0d  size=%0d",ptr_nxt,ptr,size);
    if (ptr_nxt == 5) 
      begin
        $display("  OK");
      end
    else 
      begin
        $display("  ERROR");
        $finish;
      end
    $display(PASSED);
    $finish;
  end
endmodule

