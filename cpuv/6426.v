module ovl_mutex (clock, reset, enable, test_expr, fire);
  parameter severity_level = `OVL_SEVERITY_DEFAULT;
  parameter width          = 2;
  parameter invert_mode    = 0;
  parameter property_type  = `OVL_PROPERTY_DEFAULT;
  parameter msg            = `OVL_MSG_DEFAULT;
  parameter coverage_level = `OVL_COVER_DEFAULT;
  parameter clock_edge     = `OVL_CLOCK_EDGE_DEFAULT;
  parameter reset_polarity = `OVL_RESET_POLARITY_DEFAULT;
  parameter gating_type    = `OVL_GATING_TYPE_DEFAULT;
  input                            clock, reset, enable;
  input  [width-1 : 0]             test_expr;
  output [`OVL_FIRE_WIDTH-1 : 0]   fire;
  parameter assert_name = "OVL_MUTEX";
  `include "std_ovl_reset.h"
  `include "std_ovl_clock.h"
  `include "std_ovl_cover.h"
  `include "std_ovl_task.h"
  `include "std_ovl_init.h"
`ifdef OVL_SVA
  `include "./sva05/ovl_mutex_logic.sv"
  assign fire = {`OVL_FIRE_WIDTH{1'b0}};
`endif
  `endmodule