module oob_controller (
input               rst,              
input               clk,
input               platform_ready,   
output  reg         linkup,           
output  reg         tx_comm_reset,     
output  reg         tx_comm_wake,     
input               comm_init_detect, 
input               comm_wake_detect, 
input       [31:0]  rx_din,
input       [3:0]   rx_isk,
input               rx_is_elec_idle,
input               rx_byte_is_aligned,
output  reg [31:0]  tx_dout,
output  reg         tx_isk,
output  reg         tx_set_elec_idle,
output      [3:0]   lax_state
);
parameter           IDLE                    = 4'h0;
parameter           SEND_RESET              = 4'h1;
parameter           WAIT_FOR_INIT           = 4'h2;
parameter           WAIT_FOR_NO_INIT        = 4'h3;
parameter           WAIT_FOR_CONFIGURE_END  = 4'h4;
parameter           SEND_WAKE               = 4'h5;
parameter           WAIT_FOR_WAKE           = 4'h6;
parameter           WAIT_FOR_NO_WAKE        = 4'h7;
parameter           WAIT_FOR_ALIGN          = 4'h8;
parameter           SEND_ALIGN              = 4'h9;
parameter           DETECT_SYNC             = 4'hA;
parameter           READY                   = 4'hB;
reg         [3:0]   state;
reg         [31:0]  timer;
reg         [1:0]   no_align_count;
wire                timeout;
wire                align_detected;
wire                sync_detected;
assign              timeout         = (timer == 0);
assign              align_detected  = ((rx_isk > 0) && (rx_din == `PRIM_ALIGN) && rx_byte_is_aligned);
assign              sync_detected   = ((rx_isk > 0) && (rx_din == `PRIM_SYNC));
assign              lax_state       = state;
initial begin
  tx_set_elec_idle      <=  1;
end
always @ (posedge clk) begin
  if (rst) begin
    state               <=  IDLE;
    linkup              <=  0;
    timer               <=  0;
    tx_comm_reset       <=  1;
    tx_comm_wake        <=  0;
    tx_dout             <=  0;
    tx_isk              <=  0;
    tx_set_elec_idle    <=  1;
    no_align_count      <=  0;
  end
  else begin
    tx_comm_reset       <=  0;
    tx_comm_wake        <=  0;
    tx_isk              <=  0;
    if (timer > 0) begin
      timer                 <=  timer - 1;
    end
    case (state)
      IDLE: begin
        linkup              <=  0;
        tx_set_elec_idle    <=  1;
        if (platform_ready) begin
          $display ("oob_controller: send RESET");
          timer             <=  32'h000000A2;
          state             <=  SEND_RESET;
        end
      end
      SEND_RESET: begin
        tx_comm_reset       <=  1;
        if (timeout) begin
          timer               <=  32'd`INITIALIZE_TIMEOUT;
          state               <=  WAIT_FOR_INIT;
          $display ("oob_controller: wait for INIT");
        end
      end
      WAIT_FOR_INIT: begin
        if (comm_init_detect) begin
          timer             <=  0;
          state             <=  WAIT_FOR_NO_INIT;
          $display ("oob_controller: wait for INIT to go low");
        end
        if (timeout) begin
          $display ("oob_controller: timed out while waiting for INIT");
          state             <=  IDLE;
        end
      end
      WAIT_FOR_NO_INIT: begin
        if (!comm_init_detect) begin
          $display ("oob_controller: INIT deasserted");
          $display ("oob_controller: start configuration");
          state             <=  WAIT_FOR_CONFIGURE_END;
        end
      end
      WAIT_FOR_CONFIGURE_END: begin
          $display ("oob_controller: System is configured");
          state             <=  SEND_WAKE;
          timer             <=  32'h0000009B;
      end
      SEND_WAKE:  begin
        tx_comm_wake        <=  1;
        if (timeout) begin
          timer               <=  32'h000203AD;
          state               <=  WAIT_FOR_WAKE;
        end
      end
      WAIT_FOR_WAKE:  begin
        if (comm_wake_detect) begin
          timer             <=  0;
          state             <=  WAIT_FOR_NO_WAKE;
          $display ("oob_controller: WAKE detected");
        end
        if (timeout) begin
          state             <=  IDLE;
          $display ("oob_controller: timed out while waiting for WAKE to be asserted");
        end
      end
      WAIT_FOR_NO_WAKE: begin
        if (!comm_wake_detect) begin
          $display ("oob_controller: detected WAKE deasserted");
          $display ("oob_controller: Send Dialtone, wait for ALIGN");
          timer             <=  32'h203AD;
          state             <=  WAIT_FOR_ALIGN;
        end
      end
      WAIT_FOR_ALIGN: begin
        tx_set_elec_idle    <=  0;
        tx_dout             <=  `DIALTONE;
        tx_isk              <=  0;
        if (align_detected) begin
          timer             <=  0;
          state             <=  SEND_ALIGN;
          no_align_count    <=  0;
          $display ("oob_controller: ALIGN detected");
          $display ("oob_controller: Send out my ALIGNs");
        end
        if (timeout) begin
          $display ("oob_controller: timed out while waiting for AIGN");
          state             <=  IDLE;
        end
      end
      SEND_ALIGN: begin
        tx_dout             <=  `PRIM_ALIGN;
        tx_isk              <=  1;
        if (!align_detected) begin
          $display ("oob_controller: detected ALIGN deasserted");
          if (no_align_count == 3) begin
            $display ("oob_controller: ready");
            state           <=  READY;
          end
          else begin
            no_align_count  <=  no_align_count + 1;
          end
        end
      end
      DETECT_SYNC: begin
        if (sync_detected) begin
          state             <=  READY;
        end
      end
      READY:  begin
        linkup      <=  1;
        if (comm_init_detect) begin
          state             <=  IDLE;
        end
      end
      default: begin
        state       <=  IDLE;
      end
    endcase
  end
end
endmodule