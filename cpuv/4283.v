module reg_41(clk, output__valid, output__payload, output__ready, new_en, new_value, rst);
  reg \initial  = 0;
  (* src = "/media/tim/GIT/tcal-x/CFU-Playground/proj/hps_accel/gateware/stream/stream.py:98" *)
  wire \$1 ;
  (* src = "/media/tim/GIT/tcal-x/CFU-Playground/third_party/python/nmigen/nmigen/hdl/ir.py:524" *)
  input clk;
  (* src = "/media/tim/GIT/tcal-x/CFU-Playground/proj/hps_accel/gateware/gen1/set.py:49" *)
  input new_en;
  (* src = "/media/tim/GIT/tcal-x/CFU-Playground/proj/hps_accel/gateware/gen1/set.py:50" *)
  input [31:0] new_value;
  (* src = "/media/tim/GIT/tcal-x/CFU-Playground/proj/hps_accel/gateware/gen1/set.py:47" *)
  output [31:0] output__payload;
  reg [31:0] output__payload = 32'd0;
  (* src = "/media/tim/GIT/tcal-x/CFU-Playground/proj/hps_accel/gateware/gen1/set.py:47" *)
  reg [31:0] \output__payload$next ;
  (* src = "/media/tim/GIT/tcal-x/CFU-Playground/proj/hps_accel/gateware/gen1/set.py:47" *)
  input output__ready;
  (* src = "/media/tim/GIT/tcal-x/CFU-Playground/proj/hps_accel/gateware/gen1/set.py:47" *)
  output output__valid;
  reg output__valid = 1'h0;
  (* src = "/media/tim/GIT/tcal-x/CFU-Playground/proj/hps_accel/gateware/gen1/set.py:47" *)
  reg \output__valid$next ;
  (* src = "/media/tim/GIT/tcal-x/CFU-Playground/third_party/python/nmigen/nmigen/hdl/ir.py:524" *)
  input rst;
  assign \$1  = output__valid & (* src = "/media/tim/GIT/tcal-x/CFU-Playground/proj/hps_accel/gateware/stream/stream.py:98" *) output__ready;
  always @(posedge clk)
    output__payload <= \output__payload$next ;
  always @(posedge clk)
    output__valid <= \output__valid$next ;
  always @* begin
    if (\initial ) begin end
    \output__valid$next  = output__valid;
    (* src = "/media/tim/GIT/tcal-x/CFU-Playground/proj/hps_accel/gateware/gen1/set.py:53" *)
    casez (\$1 )
      1'h1:
          \output__valid$next  = 1'h0;
    endcase
    (* src = "/media/tim/GIT/tcal-x/CFU-Playground/proj/hps_accel/gateware/gen1/set.py:56" *)
    casez (new_en)
      1'h1:
          \output__valid$next  = 1'h1;
    endcase
    (* src = "/media/tim/GIT/tcal-x/CFU-Playground/third_party/python/nmigen/nmigen/hdl/xfrm.py:519" *)
    casez (rst)
      1'h1:
          \output__valid$next  = 1'h0;
    endcase
  end
  always @* begin
    if (\initial ) begin end
    \output__payload$next  = output__payload;
    (* src = "/media/tim/GIT/tcal-x/CFU-Playground/proj/hps_accel/gateware/gen1/set.py:56" *)
    casez (new_en)
      1'h1:
          \output__payload$next  = new_value;
    endcase
    (* src = "/media/tim/GIT/tcal-x/CFU-Playground/third_party/python/nmigen/nmigen/hdl/xfrm.py:519" *)
    casez (rst)
      1'h1:
          \output__payload$next  = 32'd0;
    endcase
  end
endmodule