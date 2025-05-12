
module t(clk);

  input  clk;
  integer cyc;

  
  initial    cyc = 1;
  reg  [255:0] i;

  wire [255:0] q;

  assign q = {i[176],i[168],i[126],i[177],i[97],i[123],i[231],i[39],i[89],i[49],i[113],i[232],i[7],i[117],i[63],i[93]};
  
  always @(posedge clk)
      begin
        if (cyc != 0) 
          begin
            cyc <= cyc+1;
            if (cyc == 1) 
              begin
                i <= 256'hed388e646c843d35de489bab2413d77045e0eb7642b148537491f3da147e7f26;
              end
              
            if (cyc == 2) 
              begin
                i <= 256'h0e17c88f3d5fe51a982646c8e2bd68c3e236ddfddddbdad20a48e039c9f395b8;
                if (q != 256'h697bad4b0cf2d7fa4ad22809293710bb67d1eb3131e8eb2135f2c7bd820baa84) 
                  $stop;
                  
              end
              
            if (cyc == 3) 
              begin
                if (q != 256'h320eda5078b3e942353d16dddc8b29fd773b4fcec8323612dadfb1fa483f602c) 
                  $stop;
                  
              end
              
            if (cyc == 4) 
              begin
                $write("*-* All Finished *-*\n");
                $finish;
              end
              
          end
          
      end
endmodule

