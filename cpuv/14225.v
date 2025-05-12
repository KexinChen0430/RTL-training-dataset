module bug26968 ();
   reg [4:0]  vect = 5'b10100;
   wire [4:0] tmp = { vect[0], vect[1], vect[2], vect[3], vect[4] };
   initial begin
      #1 $display("vect=%b, tmp=%b", vect, tmp);
   end
endmodule