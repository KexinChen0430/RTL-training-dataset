
module decoder(cx,d);

  output [6:0] d;
  input  [11:0] cx;
  reg  [6:0] d;
  reg  [4:0] s;
  reg  [11:0] cx1;
  parameter  s0 = 5'b11110;
  parameter  s1 = 5'b10111;
  parameter  s2 = 5'b01000;
  parameter  s3 = 5'b00111;
  parameter  s4 = 5'b01000;
  parameter  s5 = 5'b11111;
  parameter  s6 = 5'b10111;
  parameter  s7 = 5'b10000;
  parameter  s8 = 5'b01000;
  parameter  s9 = 5'b00100;
  parameter  s10 = 5'b00010;
  parameter  s11 = 5'b00001;

  
  always @(cx)
      begin
        cx1[0] = cx[0];
        cx1[1] = cx[1];
        cx1[11] = cx[11];
        s[0] = (cx[0]+cx[1])+((cx[7]+cx[6])+cx[5]);
        s[1] = (cx[2]+(cx[5]+cx[8]))+(cx[4]+cx[0]);
        s[4] = cx[6]+((cx[1]+cx[5])+(cx[11]+cx[3]));
        case (s)

          s0: begin
                if (cx[0] == 1'b0) cx1[0] = 1'b1;
                else cx1[0] = 1'b0;
              end

          s11: begin
                if (cx[11] == 1'b0) cx1[11] = 1'b1;
                else cx1[11] = 1'b0;
              end

          default: begin
                cx1[0] = cx[0];
                cx1[11] = cx[11];
              end

        endcase

        d[0] = cx1[0];
        d[6] = cx1[6];
      end
endmodule

