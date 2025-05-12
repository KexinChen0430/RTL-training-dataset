
module LUT4(output O,
            input  I0,I1,I2,I3);

  parameter [15:0]  INIT = 16'h0;
  parameter  EQN = "(I0)";

  
  specify
    (I0 => O) = 995;
    (I1 => O) = 1437;
    (I2 => O) = 1593;
    (I3 => O) = 1887;
  endspecify

  wire [7:0]  s3 = I3 ? INIT[15:8] : INIT[7:0];

  wire [3:0]  s2 = I2 ? s3[7:4] : s3[3:0];

  wire [1:0]  s1 = I1 ? s2[3:2] : s2[1:0];

  assign O = I0 ? s1[1] : s1[0];
endmodule

