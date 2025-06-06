
module Altera_UP_PS2_Data_In(clk,reset,wait_for_incoming_data,start_receiving_data,
                             ps2_clk_posedge,ps2_clk_negedge,ps2_data,received_data,
                             received_data_en);

  input  clk;
  input  reset;
  input  wait_for_incoming_data;
  input  start_receiving_data;
  input  ps2_clk_posedge;
  input  ps2_clk_negedge;
  input  ps2_data;
  output reg [7:0] received_data;
  output reg received_data_en;
  localparam 
       PS2_STATE_0_IDLE          = 3'h0,
       PS2_STATE_1_WAIT_FOR_DATA = 3'h1,
       PS2_STATE_2_DATA_IN       = 3'h2,
       PS2_STATE_3_PARITY_IN     = 3'h3,
       PS2_STATE_4_STOP_IN       = 3'h4;
  reg  [3:0] data_count;
  reg  [7:0] data_shift_reg;
  reg  [2:0] ns_ps2_receiver;
  reg  [2:0] s_ps2_receiver;

  
  always @(posedge clk)
      begin
        if (reset == 1'b1) s_ps2_receiver <= PS2_STATE_0_IDLE;
        else s_ps2_receiver <= ns_ps2_receiver;
      end
  
  always @(*)
      begin
        ns_ps2_receiver = PS2_STATE_0_IDLE;
        case (s_ps2_receiver)

          PS2_STATE_0_IDLE: begin
                if ((received_data_en == 1'b0) && 
                    (wait_for_incoming_data == 1'b1)) ns_ps2_receiver = PS2_STATE_1_WAIT_FOR_DATA;
                else if ((received_data_en == 1'b0) && 
                         (start_receiving_data == 1'b1)) ns_ps2_receiver = PS2_STATE_2_DATA_IN;
                  
              end

          PS2_STATE_1_WAIT_FOR_DATA: begin
                if ((ps2_data == 1'b0) && (ps2_clk_posedge == 1'b1)) ns_ps2_receiver = PS2_STATE_2_DATA_IN;
                else if (wait_for_incoming_data == 1'b0) ns_ps2_receiver = PS2_STATE_0_IDLE;
                  
              end

          PS2_STATE_2_DATA_IN: begin
                if ((ps2_clk_posedge == 1'b1) && (data_count == 3'h7)) ns_ps2_receiver = PS2_STATE_3_PARITY_IN;
                  
              end

          PS2_STATE_3_PARITY_IN: begin
                if (ps2_clk_posedge == 1'b1) ns_ps2_receiver = PS2_STATE_4_STOP_IN;
                  
              end

          PS2_STATE_4_STOP_IN: begin
                if (ps2_clk_posedge == 1'b1) ns_ps2_receiver = PS2_STATE_0_IDLE;
                  
              end

          default: begin
                ns_ps2_receiver = PS2_STATE_0_IDLE;
              end

        endcase

      end
  
  always @(posedge clk)
      begin
        if (reset == 1'b1) data_count <= 3'h0;
        else if ((s_ps2_receiver == PS2_STATE_2_DATA_IN) && 
                 (ps2_clk_posedge == 1'b1)) data_count <= 3'h1+data_count;
        else if (s_ps2_receiver != PS2_STATE_2_DATA_IN) data_count <= 3'h0;
          
      end
  
  always @(posedge clk)
      begin
        if (reset == 1'b1) data_shift_reg <= 8'h00;
        else if ((s_ps2_receiver == PS2_STATE_2_DATA_IN) && 
                 (ps2_clk_posedge == 1'b1)) data_shift_reg <= {ps2_data,data_shift_reg[7:1]};
          
      end
  
  always @(posedge clk)
      begin
        if (reset == 1'b1) received_data <= 8'h00;
        else if (s_ps2_receiver == PS2_STATE_4_STOP_IN) received_data <= data_shift_reg;
          
      end
  
  always @(posedge clk)
      begin
        if (reset == 1'b1) received_data_en <= 1'b0;
        else if ((s_ps2_receiver == PS2_STATE_4_STOP_IN) && 
                 (ps2_clk_posedge == 1'b1)) received_data_en <= 1'b1;
        else received_data_en <= 1'b0;
      end
endmodule

