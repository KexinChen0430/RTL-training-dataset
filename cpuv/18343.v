module ps2_mouse_datain (
    input            clk, 
    input            reset, 
    input            wait_for_incoming_data, 
    input            start_receiving_data, 
    input            ps2_clk_posedge, 
    input            ps2_clk_negedge, 
    input            ps2_data, 
    output reg [7:0] received_data, 
    output reg       received_data_en 
  );
  localparam PS2_STATE_0_IDLE          = 3'h0, 
             PS2_STATE_1_WAIT_FOR_DATA = 3'h1, 
             PS2_STATE_2_DATA_IN       = 3'h2, 
             PS2_STATE_3_PARITY_IN     = 3'h3, 
             PS2_STATE_4_STOP_IN       = 3'h4; 
  reg [3:0] data_count; 
  reg [7:0] data_shift_reg; 
  reg [2:0] ns_ps2_receiver; 
  reg [2:0] s_ps2_receiver; 
  always @(posedge clk) begin
    if (reset == 1'b1) s_ps2_receiver <= PS2_STATE_0_IDLE; 
    else               s_ps2_receiver <= ns_ps2_receiver; 
  end
  always @(*) begin
    ns_ps2_receiver = PS2_STATE_0_IDLE; 
    case (s_ps2_receiver) 
  always @(posedge clk) begin
  end
  always @(posedge clk) begin
  end
  always @(posedge clk) begin
  end
  always @(posedge clk) begin
  end
endmodule