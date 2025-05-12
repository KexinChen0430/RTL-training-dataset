module srio_gen2_0_srio_rst
   (
    input            cfg_clk,                 
    input            log_clk,                 
    input            phy_clk,                 
    input            gt_pcs_clk,              
    input            sys_rst,                 
    input            port_initialized,        
    input            phy_rcvd_link_reset,     
    input            force_reinit,            
    input            clk_lock,                
    output reg       controlled_force_reinit, 
    output           cfg_rst,                 
    output           log_rst,                 
    output           buf_rst,                 
    output           phy_rst,                 
    output           gt_pcs_rst               
   );
  localparam  IDLE       = 4'b0001;
  localparam  LINKRESET  = 4'b0010;
  localparam  PHY_RESET1 = 4'b0100;
  localparam  PHY_RESET2 = 4'b1000;
  wire sys_rst_buffered;
  reg   [0:3]   reset_state      = IDLE;
  reg   [0:3]   reset_next_state = IDLE;
 (* ASYNC_REG = "TRUE" *)
  reg  [3:0]        cfg_rst_srl;
 (* ASYNC_REG = "TRUE" *)
  reg  [3:0]        log_rst_srl;
 (* ASYNC_REG = "TRUE" *)
  reg  [3:0]        phy_rst_srl;
 (* ASYNC_REG = "TRUE" *)
  reg  [3:0]        gt_pcs_rst_srl;
  reg               sys_rst_int;
  wire              reset_condition = sys_rst || phy_rcvd_link_reset || sys_rst_int;
  assign cfg_rst = cfg_rst_srl[3];
  always @(posedge cfg_clk or posedge reset_condition) begin
    if (reset_condition) begin
      cfg_rst_srl <= 4'b1111;
    end else if (clk_lock) begin
      cfg_rst_srl <= {cfg_rst_srl[2:0], 1'b0};
    end
  end
  assign log_rst = log_rst_srl[3];
  always @(posedge log_clk or posedge reset_condition) begin
    if (reset_condition) begin
      log_rst_srl <= 4'b1111;
    end else if (clk_lock) begin
      log_rst_srl <= {log_rst_srl[2:0], 1'b0};
    end
  end
  assign buf_rst = reset_condition;
  assign phy_rst = phy_rst_srl[3];
  always @(posedge phy_clk or posedge reset_condition) begin
    if (reset_condition) begin
      phy_rst_srl <= 4'b1111;
    end else if (clk_lock) begin
      phy_rst_srl <= {phy_rst_srl[2:0], 1'b0};
    end
  end
  assign gt_pcs_rst = gt_pcs_rst_srl[3];
  always @(posedge gt_pcs_clk or posedge reset_condition) begin
    if (reset_condition) begin
      gt_pcs_rst_srl <= 4'b1111;
    end else if (clk_lock) begin
      gt_pcs_rst_srl <= {gt_pcs_rst_srl[2:0], 1'b0};
    end
  end
  always@(posedge log_clk) begin
    reset_state <= reset_next_state;
  end
  always @* begin
    casex (reset_state)
      IDLE: begin
        sys_rst_int             = 1'b0;
        controlled_force_reinit = 1'b0;
        if (force_reinit)
          reset_next_state = LINKRESET;
        else
          reset_next_state = IDLE;
      end
      LINKRESET: begin
        sys_rst_int             = 1'b0;
        controlled_force_reinit = 1'b1;
        if (~port_initialized)
          reset_next_state = PHY_RESET1;
        else
          reset_next_state = LINKRESET;
      end
      PHY_RESET1: begin
        sys_rst_int             = 1'b1;
        controlled_force_reinit = 1'b0;
        reset_next_state = PHY_RESET2;
      end
      PHY_RESET2: begin
        sys_rst_int             = 1'b1;
        controlled_force_reinit = 1'b0;
        if (force_reinit)
          reset_next_state = PHY_RESET2;
        else
          reset_next_state = IDLE;
      end
      default: begin
        sys_rst_int             = 1'b0;
        controlled_force_reinit = 1'b0;
        reset_next_state = IDLE;
      end
    endcase
  end
endmodule