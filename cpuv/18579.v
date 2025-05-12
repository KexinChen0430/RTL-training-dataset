module main;
   reg [7:0] foo;
   initial begin
      foo = 8'b11001001;
      $display("%b", foo[3:0]);
      $display("%b", foo[4:1]);
      $display("%b", foo[5:2]);
      $display("%b", foo[6:3]);
      $display("%b", foo[7:4]);
   end
endmodule