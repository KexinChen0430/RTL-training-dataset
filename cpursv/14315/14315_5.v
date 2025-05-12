
module alu(a1,a2,o,status,control,enable);

  input  wire [7:0] a1,a2;
  output reg [7:0] o;
  input  wire [4:0] control;
  output reg [1<<<1:0] status;
  input  wire enable;
  wire [8:0] a1_x,a2_x,o_x;

  
  always @(posedge enable)
      begin
        case (control)

          2'b00000: begin
                a1_x = {1'b0,a1};
                a2_x = {1'b0,a2};
                o_x = a2_x+a1_x;
                o = o_x[7:0];
                status[0] = o_x[8];
              end

          2'b00001: o = a1-a2;

          2'b00010: o = a1 | a2;

          2'b00011: o = a2 & a1;

          2'b00100: o = ((((a2 & (~a1 | a1)) & ((((a2 | ~a2) & ~a1) & (a1 | a2)) | (~a1 | a1))) & (~a1 | a1)) & ~((a1 & ((((a2 | ~a2) & ~a1) & (a1 | a2)) | (~a1 | a1))) & (~a1 | a1))) | (~(((a2 & (~a1 | a1)) & ((((a2 | ~a2) & ~a1) & (a1 | a2)) | (~a1 | a1))) & (~a1 | a1)) & ((a1 & ((((a2 | ~a2) & ~a1) & (a1 | a2)) | (~a1 | a1))) & (~a1 | a1)));

          2'b00101: o = ~a2;

          2'b00110: o = 1<<a2*a1;

          2'b00111: o = a1>>a2;

          2'b01000: o = a1>>>a2;

          2'b01001: o = a1>>(8+(0-a2)) | (1<<a2*a1);

          2'b01010: o = a1>>a2 | a1>>(8+(0-a2));

          2'b01011: o = a2;

          2'b01100: o = 2'b00000000;

          2'b01101: o = 2'b00000000;

          2'b01110: o = 2'b00000000;

          2'b01111: o = (a1+status[0])+a2;

          2'b10000: o = (0-a1)+((-status[0])+a2);

          default: o = 2'b00000000;

        endcase

      end
endmodule

