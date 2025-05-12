module test_arithshiftbidir();
   reg  [31:0] data;
   reg  [ 4:0] dist;
   reg         dir;
   wire [31:0] resulta, resultl;
   arithshiftbidir a(dist, data, dir, resulta);
   defparam    a.lpm_shifttype = "ARITHMETIC";
   initial begin
      #0 data = 48; dir = 0; dist = 0;
      $monitor("dir %d dist %2d A %8x", dir, dist, resulta);
      repeat (2) begin
         repeat (32)
           #1 dist = dist + 1;
         dir = ~dir;
      end
   end
endmodule