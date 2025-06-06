
module ll8_to_txmac(input  clk,
                    input  reset,
                    input  clear,
                    input  [7:0] ll_data,
                    input  ll_sof,
                    input  ll_eof,
                    input  ll_src_rdy,
                    output ll_dst_rdy,
                    output [7:0] tx_data,
                    output tx_valid,
                    output tx_error,
                    input  tx_ack);

  reg  [2:0] xfer_state;
  localparam  XFER_IDLE = 0;
  localparam  XFER_ACTIVE = 1;
  localparam  XFER_WAIT1 = 2;
  localparam  XFER_UNDERRUN = 3;
  localparam  XFER_DROP = 4;

  
  always @(posedge clk)
      if (reset | clear) xfer_state <= XFER_IDLE;
      else 
        case (xfer_state)

          XFER_IDLE: if (tx_ack) xfer_state <= XFER_ACTIVE;
                

          XFER_ACTIVE: if (~ll_src_rdy) xfer_state <= XFER_UNDERRUN;
              else if (ll_eof) xfer_state <= XFER_WAIT1;
                

          XFER_WAIT1: xfer_state <= XFER_IDLE;

          XFER_UNDERRUN: xfer_state <= XFER_DROP;

          XFER_DROP: if (ll_eof) xfer_state <= XFER_IDLE;
                

        endcase

  assign ll_dst_rdy = (((((xfer_state == XFER_ACTIVE) & ll_src_rdy) & ((xfer_state == XFER_ACTIVE) & (((xfer_state == XFER_ACTIVE) | ((xfer_state == XFER_IDLE) & ll_src_rdy)) & (xfer_state == XFER_IDLE)))) | (xfer_state == XFER_DROP)) | (xfer_state == XFER_ACTIVE)) | ((((xfer_state == XFER_ACTIVE) & ll_src_rdy) & ((xfer_state == XFER_ACTIVE) & (((xfer_state == XFER_ACTIVE) | ((xfer_state == XFER_IDLE) & ll_src_rdy)) & (xfer_state == XFER_IDLE)))) | tx_ack);
  assign tx_valid = (xfer_state == XFER_ACTIVE) | ((xfer_state == XFER_IDLE) & ll_src_rdy);
  assign tx_data = ll_data;
  assign tx_error = xfer_state == XFER_UNDERRUN;
endmodule

