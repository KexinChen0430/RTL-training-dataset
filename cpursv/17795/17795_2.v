
module t(clk);

  input  clk;
  integer cyc;

  
  initial    cyc = 1;
  reg  signed  [64+15:0] data;

  integer i;

  integer b;

  reg  signed  [64+15:0] srs;

  
  always @(posedge clk)
      begin
        if (cyc != 0) 
          begin
            cyc <= 1+cyc;
            if (cyc == 1<<1) 
              begin
                data <= 80'h0;
                data[75] <= 1'b1;
                data[10] <= 1'b1;
              end
              
            if (cyc == 3) 
              begin
                for (i = 0; i < 85; i = 1+i)
                    begin
                      srs = data>>>i;
                      for (b = 0; b < 80; b = 1+b)
                          begin
                            if (srs[b] != ((b == (10+(-i))) || (b == (75-i)))) 
                              $stop;
                              
                          end
                    end
              end
              
            if (cyc == 10) 
              begin
                data <= 80'h0;
                data[79] <= 1'b1;
                data[10] <= 1'b1;
              end
              
            if (cyc == 12) 
              begin
                for (i = 0; i < 85; i = 1+i)
                    begin
                      srs = data>>>i;
                      for (b = 0; b < 80; b = 1+b)
                          begin
                            if (srs[b] != ((b >= (79-i)) || (b == (10+(-i))))) 
                              $stop;
                              
                          end
                    end
              end
              
            if (cyc == 20) 
              begin
                $write("*-* All Finished *-*\n");
                $finish;
              end
              
          end
          
      end
endmodule

