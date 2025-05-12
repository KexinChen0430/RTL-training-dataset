module t ();  
   logic [3:0] array_simp [1:0] [3:0];  
   initial begin  
      array_simp[0] = '{ 4'd3, 4'd2, 4'd1, 4'd0};  
      if ({array_simp[0][3],array_simp[0][2],array_simp[0][1],array_simp[0][0]} !== 16'h3210) $stop;
      array_simp[0] = '{ 3 ,2 ,1, 0 };  
      if ({array_simp[0][3],array_simp[0][2],array_simp[0][1],array_simp[0][0]} !== 16'h3210) $stop;
      array_simp = '{ '{ 4'd3, 4'd2, 4'd1, 4'd0 }, '{ 4'd1, 4'd2, 4'd3, 4'd4 }};
      if ({array_simp[1][3],array_simp[1][2],array_simp[1][1],array_simp[1][0],
	   array_simp[0][3],array_simp[0][2],array_simp[0][1],array_simp[0][0]} !== 32'h3210_1234) $stop;
      $write("*-* All Finished *-*\n");  
      $finish;  
   end
endmodule