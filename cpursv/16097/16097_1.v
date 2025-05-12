
module sbox3(addr,dout);

  input  [1:6] addr;
  output [1:4] dout;
  reg  [1:4] dout;

  
  always @(addr)
      begin
        case ({addr[1],addr[6],addr[2:5]})

          0: dout = 10;

          1: dout = 0;

          2: dout = 9;

          3: dout = 14;

          4: dout = 6;

          5: dout = 3;

          6: dout = 15;

          7: dout = 5;

          8: dout = 1;

          9: dout = 13;

          10: dout = 12;

          11: dout = 7;

          12: dout = 11;

          13: dout = 4;

          14: dout = 2;

          15: dout = 8;

        endcase

      end
endmodule

