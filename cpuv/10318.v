module ovl_hold_value (clock, reset, enable, test_expr, value, fire);
  parameter severity_level = `OVL_SEVERITY_DEFAULT;
  parameter min            = 0;
  parameter max            = 0;
  parameter width          = 2;
  parameter property_type  = `OVL_PROPERTY_DEFAULT;
  parameter msg            = `OVL_MSG_DEFAULT;
  parameter coverage_level = `OVL_COVER_DEFAULT;
  parameter clock_edge     = `OVL_CLOCK_EDGE_DEFAULT;
  parameter reset_polarity = `OVL_RESET_POLARITY_DEFAULT;
  parameter gating_type    = `OVL_GATING_TYPE_DEFAULT;
  input                            clock, reset, enable;
  input  [width-1 : 0]             test_expr;
  input  [width-1 : 0]             value;
  output [`OVL_FIRE_WIDTH-1 : 0]   fire;
  parameter assert_name = "OVL_HOLD_VALUE";
  `include "std_ovl_reset.h"
  `include "std_ovl_clock.h"
  `include "std_ovl_cover.h"
  `include "std_ovl_task.h"
  `include "std_ovl_init.h"
`ifdef OVL_SVA
  `include "./sva05/ovl_hold_value_logic.sv"
  assign fire = {`OVL_FIRE_WIDTH{1'b0}};
`endif
`endmodule