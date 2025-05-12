
module decoder(cx,d);

  output [3:0] d;
  input  [13:0] cx;
  reg  [3:0] d;
  reg  [3:0] s;
  reg  [13:0] cx1;
  parameter  s0 = 4'b1000000000;
  parameter  s1 = 4'b0100000000;
  parameter  s2 = 4'b0010000000;
  parameter  s3 = 4'b0001000000;
  parameter  s4 = 4'b0000100000;
  parameter  s5 = 4'b0000010000;
  parameter  s6 = 4'b0000001000;
  parameter  s7 = 4'b0000000100;
  parameter  s8 = 4'b0000000010;
  parameter  s9 = 4'b0000000001;
  parameter  s10 = 4'b1110110101;
  parameter  s11 = 4'b0101101100;
  parameter  s12 = 4'b0011100011;
  parameter  s13 = 4'b0000011111;

  
  always @(cx)
      begin
        cx1[0] = cx[0];
        cx1[1] = cx[1];
        cx1[13] = cx[13];
        s[0] = cx[10]+cx[0];
        s[1] = (cx[11]+cx[1])+cx[10];
        s[9] = (cx[12]+cx[13])+(cx[10]+cx[9]);
        case (s)

          s0: begin
                if (cx[0] == 1'b0) cx1[0] = 1'b1;
                else cx1[0] = 1'b0;
              end

          s13: begin
                if (cx[13] == 1'b0) cx1[13] = 1'b1;
                else cx1[13] = 1'b0;
              end

          default: begin
                cx1[0] = cx[0];
                cx1[13] = cx[13];
              end

        endcase

        d[0] = cx1[10];
        d[1] = cx1[11];
        d[2] = cx1[12];
        d[3] = cx1[13];
      end
endmodule

