module LUT_FF_MACRO (I0, I1, I2, I3, CLK, Z, QZ);
    (* NO_SEQ *)
    input  wire  I0;
    (* NO_SEQ *)
    input  wire  I1;
    (* NO_SEQ *)
    input  wire  I2;
    (* NO_SEQ *)
    input  wire  I3;
    input  wire  CLK;
    (* DELAY_CONST_I0="1e-10" *)
    (* DELAY_CONST_I1="1e-10" *)
    (* DELAY_CONST_I2="1e-10" *)
    (* DELAY_CONST_I3="1e-10" *)
    output wire  Z;
    (* DELAY_CONST_I0="2e-10" *)
    (* DELAY_CONST_I1="2e-10" *)
    (* DELAY_CONST_I2="2e-10" *)
    (* DELAY_CONST_I3="2e-10" *)
    (* CLK_TO_Q="CLK 1e-10" *)
    (* SETUP="CLK 1e-10" *)
    (* HOLD="CLK 1e-10" *)
    output reg   QZ;
    parameter [15:0] INIT = 16'd0;
    assign Z = INIT[{I3, I2, I1, I0}];
    always @(posedge CLK)
        QZ <= Z;
endmodule