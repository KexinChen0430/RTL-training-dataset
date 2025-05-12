module t;  
   integer seeda;  
   integer seedb;  
   integer seedc;  
   int valuea;  
   int valueb;  
   int valuec;  
   initial begin  
      seeda = 10;  
      valuea = $random(seeda);  
      seedb = 10;  
      valueb = $random(seedb);  
      if (valuea !== valueb) $stop;  
      seeda = 10;  
      valuea = $random(seeda);  
      seedb = seeda;  
      valueb = $random(seedb);  
      seedc = seedb;  
      valuec = $random(seedc);  
      if (valuea == valueb && valueb == valuec) $stop;  
      if (seeda == seedb && seedb == seedc) $stop;  
      valuea = $urandom(10);  
      valueb = $urandom(10);  
      if (valuea !== valueb) $stop;  
      valuea = $urandom(10);  
      valueb = $urandom();  
      valuec = $urandom();  
      if (valuea == valueb && valueb == valuec) $stop;  
      $write("*-* All Finished *-*\n");  
      $finish;  
   end  
endmodule  