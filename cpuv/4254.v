module ping(done, start, in0, in1, rst, clk, \output );
  reg \initial  = 0;
  (* src = "/media/tim/GIT/tcal-x/CFU-Playground/proj/hps_accel/gateware/gen1/hps_cfu.py:41" *)
  wire [32:0] \$1 ;
  (* src = "/media/tim/GIT/tcal-x/CFU-Playground/proj/hps_accel/gateware/gen1/hps_cfu.py:41" *)
  wire [32:0] \$2 ;
  (* src = "/media/tim/GIT/tcal-x/CFU-Playground/third_party/python/nmigen/nmigen/hdl/ir.py:524" *)
  input clk;
  (* src = "/media/tim/GIT/tcal-x/CFU-Playground/python/nmigen_cfu/cfu.py:53" *)
  output done;
  reg done = 1'h0;
  (* src = "/media/tim/GIT/tcal-x/CFU-Playground/python/nmigen_cfu/cfu.py:53" *)
  reg \done$next ;
  (* src = "/media/tim/GIT/tcal-x/CFU-Playground/python/nmigen_cfu/cfu.py:48" *)
  input [31:0] in0;
  (* src = "/media/tim/GIT/tcal-x/CFU-Playground/python/nmigen_cfu/cfu.py:54" *)
  wire [31:0] in0s;
  (* src = "/media/tim/GIT/tcal-x/CFU-Playground/python/nmigen_cfu/cfu.py:49" *)
  input [31:0] in1;
  (* src = "/media/tim/GIT/tcal-x/CFU-Playground/python/nmigen_cfu/cfu.py:55" *)
  wire [31:0] in1s;
  (* src = "/media/tim/GIT/tcal-x/CFU-Playground/python/nmigen_cfu/cfu.py:51" *)
  output [31:0] \output ;
  reg [31:0] \output  = 32'd0;
  (* src = "/media/tim/GIT/tcal-x/CFU-Playground/python/nmigen_cfu/cfu.py:51" *)
  reg [31:0] \output$next ;
  (* src = "/media/tim/GIT/tcal-x/CFU-Playground/third_party/python/nmigen/nmigen/hdl/ir.py:524" *)
  input rst;
  (* src = "/media/tim/GIT/tcal-x/CFU-Playground/python/nmigen_cfu/cfu.py:52" *)
  input start;
  (* src = "/media/tim/GIT/tcal-x/CFU-Playground/proj/hps_accel/gateware/gen1/hps_cfu.py:38" *)
  reg [31:0] stored_value = 32'd0;
  (* src = "/media/tim/GIT/tcal-x/CFU-Playground/proj/hps_accel/gateware/gen1/hps_cfu.py:38" *)
  reg [31:0] \stored_value$next ;
  assign \$2  = in0 + (* src = "/media/tim/GIT/tcal-x/CFU-Playground/proj/hps_accel/gateware/gen1/hps_cfu.py:41" *) in1;
  always @(posedge clk)
    done <= \done$next ;
  always @(posedge clk)
    \output  <= \output$next ;
  always @(posedge clk)
    stored_value <= \stored_value$next ;
  always @* begin
    if (\initial ) begin end
    \stored_value$next  = stored_value;
    (* src = "/media/tim/GIT/tcal-x/CFU-Playground/proj/hps_accel/gateware/gen1/hps_cfu.py:39" *)
    casez (start)
      1'h1:
          \stored_value$next  = \$2 [31:0];
    endcase
    (* src = "/media/tim/GIT/tcal-x/CFU-Playground/third_party/python/nmigen/nmigen/hdl/xfrm.py:519" *)
    casez (rst)
      1'h1:
          \stored_value$next  = 32'd0;
    endcase
  end
  always @* begin
    if (\initial ) begin end
    \output$next  = \output ;
    (* src = "/media/tim/GIT/tcal-x/CFU-Playground/proj/hps_accel/gateware/gen1/hps_cfu.py:39" *)
    casez (start)
      1'h1:
          \output$next  = stored_value;
    endcase
    (* src = "/media/tim/GIT/tcal-x/CFU-Playground/third_party/python/nmigen/nmigen/hdl/xfrm.py:519" *)
    casez (rst)
      1'h1:
          \output$next  = 32'd0;
    endcase
  end
  always @* begin
    if (\initial ) begin end
    (* full_case = 32'd1 *)
    (* src = "/media/tim/GIT/tcal-x/CFU-Playground/proj/hps_accel/gateware/gen1/hps_cfu.py:39" *)
    casez (start)
      1'h1:
          \done$next  = 1'h1;
      default:
          \done$next  = 1'h0;
    endcase
    (* src = "/media/tim/GIT/tcal-x/CFU-Playground/third_party/python/nmigen/nmigen/hdl/xfrm.py:519" *)
    casez (rst)
      1'h1:
          \done$next  = 1'h0;
    endcase
  end
  assign \$1  = \$2 ;
  assign in1s = in1;
  assign in0s = in0;
endmodule