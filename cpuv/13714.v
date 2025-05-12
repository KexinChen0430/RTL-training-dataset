module foo; 
   initial begin 
      k  = 10; 
      std::randomize(delay) with { (delay>=1000 && delay<=3000); };
      j  = 9; 
   end 
endmodule 