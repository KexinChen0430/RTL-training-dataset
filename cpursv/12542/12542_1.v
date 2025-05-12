
module drives(input  [3:0] num,
              output reg [0:6] hexd1,
              output reg [0:6] hexd2);

  
  always @(num)
      case (num)

        4'b0000: begin
              hexd1 = 7'b0000001;
              hexd2 = 7'b0000001;
            end

        4'b0001: begin
              hexd1 = 7'b1001111;
              hexd2 = 7'b0000001;
            end

        4'b0010: begin
              hexd1 = 7'b0010010;
              hexd2 = 7'b0000001;
            end

        4'b0011: begin
              hexd1 = 7'b0000110;
              hexd2 = 7'b0000001;
            end

        4'b0100: begin
              hexd1 = 7'b1001100;
              hexd2 = 7'b0000001;
            end

        4'b0101: begin
              hexd1 = 7'b0100100;
              hexd2 = 7'b0000001;
            end

        4'b0110: begin
              hexd1 = 7'b0100000;
              hexd2 = 7'b0000001;
            end

        4'b0111: begin
              hexd1 = 7'b0001111;
              hexd2 = 7'b0000001;
            end

        4'b1000: begin
              hexd1 = 7'b0000000;
              hexd2 = 7'b0000001;
            end

        4'b1001: begin
              hexd1 = 7'b0001100;
              hexd2 = 7'b0000001;
            end

        4'b1010: begin
              hexd1 = 7'b0000001;
              hexd2 = 7'b1001111;
            end

        4'b1011: begin
              hexd1 = 7'b1001111;
              hexd2 = 7'b1001111;
            end

        4'b1100: begin
              hexd1 = 7'b0010010;
              hexd2 = 7'b1001111;
            end

        4'b1101: begin
              hexd1 = 7'b0000110;
              hexd2 = 7'b1001111;
            end

        4'b1110: begin
              hexd1 = 7'b1001100;
              hexd2 = 7'b1001111;
            end

        4'b1111: begin
              hexd1 = 7'b0100100;
              hexd2 = 7'b1001111;
            end

        default: begin
              hexd1 = 7'bx;
              hexd2 = 7'bx;
            end

      endcase

endmodule

