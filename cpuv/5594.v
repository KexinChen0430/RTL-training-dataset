module control(op, alu_op, regDst, aluSrc, memToReg, regWrite, memRead, memWrite, branch);
  (* src = "../control/control.v:2" *)
  input [5:0] op;
  (* src = "../control/control.v:3" *)
  output [1:0] alu_op;
  (* src = "../control/control.v:4" *)
  output regDst;
  (* src = "../control/control.v:4" *)
  output aluSrc;
  (* src = "../control/control.v:4" *)
  output memToReg;
  (* src = "../control/control.v:4" *)
  output regWrite;
  (* src = "../control/control.v:5" *)
  output memRead;
  (* src = "../control/control.v:5" *)
  output memWrite;
  (* src = "../control/control.v:5" *)
  output branch;
  (* src = "../control/control.v:8" *)
  wire int0;
  (* src = "../control/control.v:8" *)
  wire op0_bar;
  (* src = "../control/control.v:8" *)
  wire op1_bar;
  (* src = "../control/control.v:8" *)
  wire op2_bar;
  (* src = "../control/control.v:8" *)
  wire op3_bar;
  (* src = "../control/control.v:8" *)
  wire op4_bar;
  (* src = "../control/control.v:8" *)
  wire op5_bar;
  (* src = "../control/control.v:17" *)
  wire _00_;
  (* src = "../control/control.v:17" *)
  wire _01_;
  (* src = "../control/control.v:17" *)
  wire _02_;
  (* src = "../control/control.v:17" *)
  wire _03_;
  (* src = "../control/control.v:18" *)
  wire _04_;
  (* src = "../control/control.v:18" *)
  wire _05_;
  (* src = "../control/control.v:20" *)
  wire _06_;
  (* src = "../control/control.v:20" *)
  wire _07_;
  (* src = "../control/control.v:20" *)
  wire _08_;
  (* src = "../control/control.v:20" *)
  wire _09_;
  (* src = "../control/control.v:22" *)
  wire _10_;
  (* src = "../control/control.v:22" *)
  wire _11_;
  (* src = "../control/control.v:22" *)
  wire _12_;
  (* src = "../control/control.v:25" *)
  wire _13_;
  (* src = "../control/control.v:25" *)
  wire _14_;
  assign op0_bar = ~op[0];
  assign op1_bar = ~op[1];
  assign op2_bar = ~op[2];
  assign op3_bar = ~op[3];
  assign op4_bar = ~op[4];
  assign op5_bar = ~op[5];
  assign _00_ = op5_bar & op4_bar;
  assign _01_ = _00_ & op3_bar;
  assign _02_ = _01_ & op[2];
  assign _03_ = _02_ & op1_bar;
  assign alu_op[0] = _03_ & op0_bar;
  assign _04_ = _01_ & op2_bar;
  assign _05_ = _04_ & op1_bar;
  assign alu_op[1] = _05_ & op0_bar;
  assign _06_ = op[5] & op4_bar;
  assign _07_ = _06_ & op3_bar;
  assign _08_ = _07_ & op2_bar;
  assign _09_ = _08_ & op[1];
  assign int0 = _09_ & op[0];
  assign _10_ = _06_ & op[3];
  assign _11_ = _10_ & op2_bar;
  assign _12_ = _11_ & op[1];
  assign memWrite = _12_ & op[0];
  assign _13_ = _06_ & op2_bar;
  assign _14_ = _13_ & op[1];
  assign aluSrc = _14_ & op[0];
  assign regWrite = int0 | alu_op[1];
  assign regDst = alu_op[1];
  assign memToReg = int0;
  assign memRead = int0;
  assign branch = alu_op[0];
endmodule