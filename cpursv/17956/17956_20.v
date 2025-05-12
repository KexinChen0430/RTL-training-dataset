
module t(clk);

  input  clk;
  reg  [7:0] cyc;

  
  initial    cyc = 0;
  reg  genclk;

  reg  [7:0] set_both;

  wire  genthiscyc = (cyc%1<<<1) == 1;

  
  always @(posedge clk)
      begin
        cyc <= 8'h1+cyc;
        genclk <= genthiscyc;
        set_both <= cyc;
        $write("SB set_both %x <= cyc %x\n",set_both,cyc);
        if (genthiscyc) 
          begin
            if ((set_both != (cyc-8'h1)) && (cyc > 1)) 
              $stop;
              
          end
        else 
          begin
            if ((cyc > 1) && (set_both != ~(cyc-8'h1))) 
              $stop;
              
          end
        if (cyc == 10) 
          begin
            $write("*-* All Finished *-*\n");
            $finish;
          end
          
      end
  
  always @(posedge genclk)
      begin
        set_both <= ~set_both;
        $write("SB set_both %x <= cyc %x\n",set_both,~cyc);
        if ((set_both != (cyc-8'h1)) && (cyc > 1)) 
          $stop;
          
      end
endmodule

