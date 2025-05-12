module stimulus (output reg A);
  initial begin
    #0  A = 1'bx;
    #10 A = 1'bz;
    #10 A = 1'b0;
    #10 A = 1'b1;
  end
endmodule