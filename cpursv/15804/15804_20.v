
module decoder(cx,d);

  output [7:0] d;
  input  [11:0] cx;
  reg  [7:0] d;
  reg  [7:0] s;
  reg  [11:0] cx1;
  parameter  s0 = 8'b1000;
  parameter  s1 = 8'b0100;
  parameter  s2 = 8'b0010;
  parameter  s3 = 8'b0001;
  parameter  s4 = 8'b1100;
  parameter  s5 = 8'b1100;
  parameter  s6 = 8'b1001;
  parameter  s7 = 8'b0001;
  parameter  s8 = 8'b1011;
  parameter  s9 = 8'b1000;
  parameter  s10 = 8'b1110;
  parameter  s11 = 8'b0000;

  
  always @(cx)
      begin
        cx1[0] = cx[0];
        cx1[1] = cx[1];
        cx1[11] = cx[11];
        s[0] = ((cx[8]+cx[0])+cx[9])+((cx[5]+cx[4])+(cx[6]+cx[10]));
        s[3] = ((cx[3]+cx[7])+cx[6])+cx[8];
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

        d[0] = cx1[4];
        d[7] = cx1[11];
      end
endmodule

