
module sequencer_scc_sv_phase_decode  #(parameter  AVL_DATA_WIDTH = 32, DLL_DELAY_CHAIN_LENGTH = 6)
  (avl_writedata,dqsi_phase,dqs_phase,dq_phase,dqse_phase);

  input  [AVL_DATA_WIDTH-1:0] avl_writedata;
  output [2:0] dqsi_phase;
  output [6:0] dqs_phase;
  output [6:0] dq_phase;
  output [5:0] dqse_phase;
  reg  [2:0] dqsi_phase;
  reg  [6:0] dqs_phase;
  reg  [6:0] dq_phase;
  reg  [5:0] dqse_phase;

  
  always @(*)
      begin
        dqsi_phase = 3'b010;
        dqs_phase = 7'b1110110;
        dq_phase = 7'b0110100;
        dqse_phase = 6'b000110;
        case (avl_writedata[4:0])

          5'b00000: begin
                dqs_phase = 7'b0010110;
                dq_phase = 7'b1000110;
                dqse_phase = 6'b000010;
              end

          5'b00001: begin
                dqs_phase = 7'b0110110;
                dq_phase = 7'b1100110;
                dqse_phase = 6'b000011;
              end

          default: begin

              end

        endcase

      end
endmodule

