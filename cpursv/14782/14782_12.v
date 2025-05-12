
module Sinc3Filter  #(parameter  OSR = 16)
  (input  clk,
   input  en,
   input  in,
   output reg signed  [3*$clog2(OSR):0] out);

  parameter  ACC_UP = $clog2(OSR)+(0-1);
  reg  signed  [3:0] diff;
  reg  [OSR+(0-1):0] shift0;
  reg  [OSR+(0-1):0] shift1;
  reg  [OSR+(0-1):0] shift2;
  reg  signed  [ACC_UP+3:0]  acc1 = 'd0;
  reg  signed  [(ACC_UP*2)+3:0]  acc2 = 'd0;
  integer i;

  
  initial  
  begin
    shift0[0] = 1'b1;
    for (i = 1; i < OSR; i = 1+i)
        shift0[i] = ~shift0[i+(0-1)];
    shift1[0] = ~shift0[OSR+(0-1)];
    for (i = 1; i < OSR; i = 1+i)
        shift1[i] = ~shift1[i+(0-1)];
    shift2[0] = ~shift1[OSR+(0-1)];
    for (i = 1; i < OSR; i = 1+i)
        shift2[i] = ~shift2[i+(0-1)];
    out = 'd0;
  end
  
  always @(*)
      begin
        diff = 4'd0;
        case ({in,shift0[OSR+(0-1)],shift1[OSR+(0-1)],shift2[OSR+(0-1)]})

          4'b0000: diff = 4'sd0;

          4'b0001: diff = -4'sd1;

          4'b0010: diff = 4'sd3;

          4'b0011: diff = 4'sd2;

          4'b0100: diff = -4'sd3;

          4'b0101: diff = -4'sd4;

          4'b0110: diff = 4'sd0;

          4'b0111: diff = -4'sd1;

          4'b1000: diff = 4'sd1;

          4'b1001: diff = 4'sd0;

          4'b1010: diff = 4'sd4;

          4'b1011: diff = 4'sd3;

          4'b1100: diff = -4'sd2;

          4'b1101: diff = -4'sd3;

          4'b1110: diff = 4'sd1;

          4'b1111: diff = 4'sd0;

        endcase

      end
  
  always @(posedge clk)
      begin
        if (en) 
          begin
            shift0 <= {shift0[(-2)+OSR:0],in};
            shift1 <= {shift1[(-2)+OSR:0],shift0[OSR+(0-1)]};
            shift2 <= {shift2[(-2)+OSR:0],shift1[OSR+(0-1)]};
            acc1 <= diff+acc1;
            acc2 <= acc1+acc2;
            out <= acc2+out;
          end
          
      end
endmodule

