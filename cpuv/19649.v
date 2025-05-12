module t (
   fastclk 
   );
   input fastclk; 
   t_netlist tnetlist
     (
      .also_fastclk (fastclk),
      .fastclk      (fastclk)
     );
endmodule 