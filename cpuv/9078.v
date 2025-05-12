module dmac_request_generator #(
  parameter ID_WIDTH = 3,
  parameter BURSTS_PER_TRANSFER_WIDTH = 17)(
  input clk,
  input resetn,
  output [ID_WIDTH-1:0] request_id,
  input [ID_WIDTH-1:0] response_id,
  input rewind_req_valid,
  input [ID_WIDTH+3-1:0] rewind_req_data,
  output rewind_state,
  output abort_req,
  output reg completion_req_valid = 1'b0,
  output completion_req_last,
  output [1:0] completion_transfer_id,
  input req_valid,
  output reg req_ready,
  input [BURSTS_PER_TRANSFER_WIDTH-1:0] req_burst_count,
  input req_xlast,
  input enable,
  output eot
);
`include "inc_id.vh"
localparam STATE_IDLE      = 3'h0;
localparam STATE_GEN_ID    = 3'h1;
localparam STATE_REWIND_ID = 3'h2;
localparam STATE_CONSUME   = 3'h3;
localparam STATE_WAIT_LAST = 3'h4;
reg [2:0] state = STATE_IDLE;
reg [2:0] nx_state;
reg [1:0] rew_transfer_id = 1'b0;
reg rew_req_xlast;
reg [ID_WIDTH-1:0] rew_id = 'h0;
reg cur_transfer_id = 1'b0;
reg cur_req_xlast;
wire transfer_id_match;
reg nx_completion_req_valid;
reg [BURSTS_PER_TRANSFER_WIDTH-1:0] burst_count = 'h00;
reg [BURSTS_PER_TRANSFER_WIDTH-1:0] cur_burst_length = 'h00;
reg [ID_WIDTH-1:0] id;
wire [ID_WIDTH-1:0] id_next = inc_id(id);
wire incr_en;
wire incr_id;
assign eot = burst_count == 'h00;
assign request_id = id;
assign incr_en = (response_id != id_next) && (enable == 1'b1);
assign incr_id = (state == STATE_GEN_ID) && (incr_en == 1'b1);
always @(posedge clk) begin
  if (state == STATE_IDLE) begin
    burst_count <= req_burst_count;
  end else if (state == STATE_REWIND_ID) begin
    burst_count <= cur_burst_length;
  end else if (incr_id == 1'b1) begin
    burst_count <= burst_count - 1'b1;
  end
end
always @(posedge clk) begin
  if (req_ready == 1'b1 & req_valid == 1'b1) begin
    cur_req_xlast <= req_xlast;
    cur_burst_length <= req_burst_count;
  end
end
always @(posedge clk) begin
  if (resetn == 1'b0) begin
    id <= 'h0;
  end else if (state == STATE_REWIND_ID) begin
    id <= rew_id;
  end else if (incr_id == 1'b1) begin
    id <= id_next;
  end
end
always @(posedge clk) begin
  if (resetn == 1'b0) begin
    req_ready <= 1'b0;
  end else begin
    req_ready <= (nx_state == STATE_IDLE || nx_state == STATE_CONSUME);
  end
end
assign transfer_id_match = cur_transfer_id == rew_transfer_id[0];
always @(posedge clk) begin
  if (resetn == 1'b0) begin
    cur_transfer_id <= 1'b0;
  end else if (req_valid == 1'b1 && req_ready == 1'b1) begin
    cur_transfer_id <= ~cur_transfer_id;
  end
end
always @(*) begin
  nx_state = state;
  nx_completion_req_valid = 0;
  case (state)
    STATE_IDLE: begin
      if (rewind_req_valid == 1'b1) begin
        nx_state = STATE_REWIND_ID;
      end else if (req_valid == 1'b1) begin
        nx_state = STATE_GEN_ID;
      end
    end
    STATE_GEN_ID: begin
      if (rewind_req_valid == 1'b1) begin
        nx_state = STATE_REWIND_ID;
      end else if (eot == 1'b1 && incr_en == 1'b1) begin
        nx_state = STATE_IDLE;
      end
    end
    STATE_REWIND_ID: begin
      if (transfer_id_match) begin
        if (rew_req_xlast) begin
          nx_state = STATE_IDLE;
        end else begin
          nx_state = STATE_CONSUME;
        end
      end else begin
        if (rew_req_xlast) begin
          nx_state = STATE_GEN_ID;
        end else if (cur_req_xlast) begin
          nx_state = STATE_IDLE;
          nx_completion_req_valid = 1;
        end else begin
          nx_state = STATE_CONSUME;
          nx_completion_req_valid = 1;
        end
      end
    end
    STATE_CONSUME: begin
      if (req_valid) begin
        nx_completion_req_valid = 1;
        nx_state = STATE_WAIT_LAST;
      end
    end
    STATE_WAIT_LAST:begin
      if (cur_req_xlast) begin
        nx_state = STATE_IDLE;
      end else begin
        nx_state = STATE_CONSUME;
      end
    end
    default: begin
      nx_state = STATE_IDLE;
    end
  endcase
end
always @(posedge clk) begin
  if (resetn == 1'b0) begin
    state <= STATE_IDLE;
  end else begin
    state <= nx_state;
  end
end
always @(posedge clk) begin
  if (rewind_req_valid == 1'b1) begin
    {rew_transfer_id, rew_req_xlast, rew_id} <= rewind_req_data;
  end
end
always @(posedge clk) begin
  if (resetn == 1'b0) begin
    completion_req_valid <= 1'b0;
  end else begin
    completion_req_valid <= nx_completion_req_valid;
  end
end
assign completion_req_last = cur_req_xlast;
assign completion_transfer_id = rew_transfer_id;
assign rewind_state = (state == STATE_REWIND_ID);
assign abort_req = (state == STATE_REWIND_ID) && !rew_req_xlast && !cur_req_xlast;
endmodule