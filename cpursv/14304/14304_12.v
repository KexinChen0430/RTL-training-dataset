
module main;

  reg  clk;

  
  initial  
  begin
    clk = 0;
    forever #5 clk = ~clk;
  end
  
  initial    #20 $finish;
  wire w,ww,wr,w1,wwr,ww1,wr1,wwro,ww1o,wr1o;

  reg  r,rw;

  reg  error;

  assign ww = w;
  assign wr = r;
  assign w1 = 'b1;
  assign wwr = r & w;
  assign ww1 = 'b1 & w;
  assign wr1 = 'b1 & r;
  assign wwro = r | w;
  assign ww1o = 'b1 | w;
  assign wr1o = 'b1 | r;
  
  always @(posedge clk)  rw <= w;
  
  always @(posedge clk)
      begin
        #1 ;
        $display("%b %b %b %b %b %b %b : %b %b %b : %b %b",w,ww,wr,
                 w1,wwr,ww1,wr1,wwro,ww1o,wr1o,r,rw);
      end
  
  initial  
  begin
    error = 0;
    #19 ;
    if (ww !== 1'bz) 
      begin
        error = 1;
        $display("FAILED - ww s/b z, is %h",ww);
      end
      
    if (wr !== 1'bx) 
      begin
        error = 1;
        $display("FAILED - wr s/b x, is %h",wr);
      end
      
    if (w1 !== 1'b1) 
      begin
        error = 1;
        $display("FAILED - wr s/b 1, is %h",wr);
      end
      
    if (wwr !== 1'bx) 
      begin
        error = 1;
        $display("FAILED - wwr s/b x, is %h",wwr);
      end
      
    if (ww1 !== 1'bx) 
      begin
        error = 1;
        $display("FAILED - ww1 s/b x, is %h",ww1);
      end
      
    if (wr1 !== 1'bx) 
      begin
        error = 1;
        $display("FAILED - wr1 s/b x, is %h",wr1);
      end
      
    if (wwro !== 1'bx) 
      begin
        error = 1;
        $display("FAILED - wwro s/b 1, is %h",wwro);
      end
      
    if (wr1o !== 1'b1) 
      begin
        error = 1;
        $display("FAILED - wr1o s/b 1, is %h",wr1o);
      end
      
    if (r !== 1'bx) 
      begin
        error = 1;
        $display("FAILED - r s/b x, is %h",r);
      end
      
    if (rw !== 1'bz) 
      begin
        error = 1;
        $display("FAILED - rw s/b z, is %h",rw);
      end
      
    if (error === 0) 
      $display(PASSED);
      
    $finish;
  end
endmodule

