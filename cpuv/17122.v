module main; 
   reg [7:0] mem [0:1]; 
   initial begin 
      mem[0] = 0; 
      mem[1] = 1; 
      $memmonitor(mem); 
      #1 mem[0] = 4; 
      #1 mem[1] = 5; 
      #1 $finish(0); 
   end 
endmodule 