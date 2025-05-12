
module t(clk);

  input  clk;

  
  always @(posedge clk)
      begin
        if ($time >= 10) 
          begin
            $write;
            $write("default:   [%0t] 0t time [%t] No0 time  p=%p 0p=%0p\n",
                   $time,$time,$time,$time);
            $timeformat(-9,0,"",0);
            $write("-9,0,,0:   [%0t] 0t time [%t] No0 time  p=%p 0p=%0p\n",
                   $time,$time,$time,$time);
            $timeformat(-9,0,"",10);
            $write("-9,0,,10:  [%0t] 0t time [%t] No0 time  p=%p 0p=%0p\n",
                   $time,$time,$time,$time);
            $timeformat(-9,0,ns,5);
            $write("-9,0,ns,5: [%0t] 0t time [%t] No0 time  p=%p 0p=%0p\n",
                   $time,$time,$time,$time);
            $timeformat(-9,3,ns,8);
            $write("-9,3,ns,8: [%0t] 0t time [%t] No0 time  p=%p 0p=%0p\n",
                   $time,$time,$time,$time);
            $write(\n);
            $write("*-* All Finished *-*\n");
            $finish;
          end
          
      end
endmodule

