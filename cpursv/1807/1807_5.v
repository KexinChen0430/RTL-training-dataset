
module sevenseg(displayout,inputbcd);

  output [6:0] displayout;
  input  [3:0] inputbcd;
  reg  [6:0] displayout;
  parameter  bit0 = 7'b0000001;
  parameter  bit1 = 7'b0000010;
  parameter  bit2 = 7'b0000100;
  parameter  bit3 = 7'b0001000;
  parameter  bit4 = 7'b0010000;
  parameter  bit5 = 7'b0100000;
  parameter  bit6 = 7'b1000000;
  parameter 
       zero = ~(((bit1 | bit0) | bit5) | ((bit3 | bit2) | bit4));
  parameter  one = ~(bit1 | bit2);
  parameter  two = ~((bit3 | (bit6 | bit4)) | (bit1 | bit0));
  parameter  three = ~((bit6 | bit0) | (bit1 | (bit3 | bit2)));
  parameter  four = ~(bit1 | (bit2 | (bit5 | bit6)));
  parameter  five = ~((bit3 | bit0) | (bit2 | (bit5 | bit6)));
  parameter 
       six = ~((bit6 | (bit4 | bit0)) | (bit3 | (bit5 | bit2)));
  parameter  seven = ~((bit1 | bit0) | bit2);
  parameter 
       eight = ~(((bit3 | bit5) | bit4) | ((bit2 | bit6) | (bit1 | bit0)));
  parameter  nine = ~(((bit5 | bit2) | bit1) | (bit6 | bit0));
  parameter  blank = ~7'd0;

  
  always @(inputbcd)
      case (inputbcd)

        0: displayout = zero;

        1: displayout = one;

        2: displayout = two;

        3: displayout = three;

        4: displayout = four;

        5: displayout = five;

        6: displayout = six;

        7: displayout = seven;

        8: displayout = eight;

        9: displayout = nine;

        default: displayout = blank;

      endcase

endmodule

