
module hub_ram(input  clk,
               input  enable,
               input  w,
               input  wb,
               input  [13:0] a,
               input  [7:0] d8,
               output [7:0] q8);

  parameter SIZE_BYTES;
  reg  [7:0] ram[SIZE_BYTES-1:0];

  
  always @(posedge clk)
      begin
        if (wb && (w && enable)) 
          begin
            ram[a] <= d8;
          end
          
        q8 <= ram[a];
      end
endmodule

