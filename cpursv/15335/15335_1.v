
module t(clk);

  input  clk;
  integer cyc;

  
  initial    cyc = 1;
  parameter  ONE = 1;

  wire [17:10] bitout;

  reg  [7:0] allbits;

  reg  [15:0] onebit;

  sub sub[7:0](allbits,onebit,bitout);
  integer x;

  
  always @(posedge clk)
      begin
        if (cyc != 0) 
          begin
            cyc <= 1+cyc;
            if (cyc == 1) 
              begin
                allbits <= 8'hac;
                onebit <= 16'hc01a;
              end
              
            if (cyc == 2) 
              begin
                if (bitout !== 8'h07) 
                  $stop;
                  
                allbits <= 8'hca;
                onebit <= 16'h1f01;
              end
              
            if (cyc == 3) 
              begin
                if (bitout !== 8'h41) 
                  $stop;
                  
                if (sub[0].bitout !== 1'b1) 
                  $stop;
                  
                if (sub[1].bitout !== 1'b0) 
                  $stop;
                  
                if (sub[ONE].bitout !== 1'b0) 
                  $stop;
                  
                $write("*-* All Finished *-*\n");
                $finish;
              end
              
          end
          
      end
endmodule

