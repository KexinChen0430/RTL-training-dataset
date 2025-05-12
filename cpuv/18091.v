module t ();
   logic [3:0] array_simp [1:0] [3:0];  
   int         irep[1:2][1:6];
   initial begin
      array_simp[0] = '{ 4'd3, 4'd2, 4'd1, 4'd0};
      if ({array_simp[0][3],array_simp[0][2],array_simp[0][1],array_simp[0][0]}
          !== 16'h3210) $stop;
      array_simp[0] = '{ 3 ,2 ,1, 0 };
      if ({array_simp[0][3],array_simp[0][2],array_simp[0][1],array_simp[0][0]}
          !== 16'h3210) $stop;
      array_simp = '{ '{ 4'd3, 4'd2, 4'd1, 4'd0 }, '{ 4'd1, 4'd2, 4'd3, 4'd4 }};
      if ({array_simp[1][3],array_simp[1][2],array_simp[1][1],array_simp[1][0],
           array_simp[0][3],array_simp[0][2],array_simp[0][1],array_simp[0][0]}
          !== 32'h3210_1234) $stop;
      array_simp = '{2{ '{4'd3, 4'd2, 4'd1, 4'd0 } }};
      if ({array_simp[1][3],array_simp[1][2],array_simp[1][1],array_simp[1][0],
           array_simp[0][3],array_simp[0][2],array_simp[0][1],array_simp[0][0]}
          !== 32'h3210_3210) $stop;
      array_simp = '{2{ '{4{ 4'd3 }} }};
      if ({array_simp[1][3],array_simp[1][2],array_simp[1][1],array_simp[1][0],
           array_simp[0][3],array_simp[0][2],array_simp[0][1],array_simp[0][0]}
          !== 32'h3333_3333) $stop;
      irep = '{2{ '{3 {4, 5}}}};
      if ({irep[1][1], irep[1][2], irep[1][3], irep[1][4], irep[1][5], irep[1][6]}
          != {32'h4, 32'h5, 32'h4, 32'h5, 32'h4, 32'h5}) $stop;
      if ({irep[2][1], irep[2][2], irep[2][3], irep[2][4], irep[2][5], irep[2][6]}
          != {32'h4, 32'h5, 32'h4, 32'h5, 32'h4, 32'h5}) $stop;
      $write("*-* All Finished *-*\n");
      $finish;
   end
endmodule