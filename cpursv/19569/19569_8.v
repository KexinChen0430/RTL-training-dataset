
module should_optimize_to_nearly_nothing;

  reg  [4:0] a,a2,b,c,d,e;

  
  initial    a = 5'd1;
  
  always @(posedge fastclk)
      begin
        b <= a+5'd1;
        c <= b+5'd1;
      end
  
  always @(d or a or c)
      begin
        e = 5'd1+d;
        a2 = a+5'd1;
        d = 5'd1+c;
      end
  
  always @(posedge also_fastclk)
      begin
        if (_mode == 5) 
          begin
            if (a2 != 5'd2) 
              $stop;
              
            if (e != 5'd5) 
              $stop;
              
            $write("*-* All Finished *-*\n");
            $finish;
          end
          
        _mode <= _mode+1;
      end
endmodule

