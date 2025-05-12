module LUT3(output F, input I0, I1, I2);
    parameter [7:0] INIT = 0;
    specify
        (I0 => F) = (1054, 1486);
        (I1 => F) = (867, 1184);
        (I2 => F) = (555, 902);
    endspecify
    wire [3:0] s2 = I2 ? INIT[7:4] : INIT[3:0];
    wire [1:0] s1 = I1 ? s2[3:2] : s2[1:0];
    assign F = I0 ? s1[1] : s1[0];
endmodule