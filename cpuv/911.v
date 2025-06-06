module ovl_always_on_edge (
  clock, reset, enable, sampling_event, test_expr, fire, fire_comb
);
  parameter severity_level = `OVL_SEVERITY_DEFAULT;
  parameter edge_type      = `OVL_EDGE_TYPE_DEFAULT; 
  parameter property_type  = `OVL_PROPERTY_DEFAULT;
  parameter msg            = `OVL_MSG_DEFAULT;
  parameter coverage_level = `OVL_COVER_DEFAULT;
  parameter clock_edge     = `OVL_CLOCK_EDGE_DEFAULT;
  parameter reset_polarity = `OVL_RESET_POLARITY_DEFAULT;
  parameter gating_type    = `OVL_GATING_TYPE_DEFAULT;
  input clock, reset, enable;
  input sampling_event, test_expr;
  output [`OVL_FIRE_WIDTH-1:0] fire;
  output [`OVL_FIRE_WIDTH-1:0] fire_comb;
  parameter assert_name = "OVL_ALWAYS_ON_EDGE";
`ifdef SMV
 `ifdef SUBDIR
  `include "std_ovl_reset.h"
  `include "std_ovl_clock.h"
  `include "std_ovl_cover.h"
  `include "std_ovl_init.h"
`else
  `include "ovl_ported/std_ovl_reset.h"
  `include "ovl_ported/std_ovl_clock.h"
  `include "ovl_ported/std_ovl_cover.h"
  `include "ovl_ported/std_ovl_init.h"
`endif
 `else
  `include "ovl_ported/std_ovl_reset.h"
  `include "ovl_ported/std_ovl_clock.h"
  `include "ovl_ported/std_ovl_cover.h"
  `include "ovl_ported/std_ovl_task.h"
  `include "ovl_ported/std_ovl_init.h"
 `endif
`ifdef OVL_VERILOG
   `ifdef SMV
    `ifdef SUBDIR
     `include "vlog95/ovl_always_on_edge_logic2.v"
    `else
     `include "ovl_ported/vlog95/ovl_always_on_edge_logic2.v"
    `endif
   `else
    `include "./vlog95/ovl_always_on_edge_logic2.v"
   `endif
  assign fire = {1'b0, 1'b0, fire_2state};
  assign fire_comb = {1'b0, 1'b0, fire_2state_comb};
`endif
`ifdef OVL_SVA
  `include "./sva05/assert_always_on_edge_logic.sv"
  assign fire = {`OVL_FIRE_WIDTH{1'b0}}; 
`endif
`ifdef OVL_PSL
  assign fire = {`OVL_FIRE_WIDTH{1'b0}}; 
  `include "./psl05/assert_always_on_edge_psl_logic.v"
`else
  `endmodule