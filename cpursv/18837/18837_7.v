
module sequencer_scc_acv_phase_decode  #(parameter 
       AVL_DATA_WIDTH         = 32,
       DLL_DELAY_CHAIN_LENGTH = 8,
       USE_2X_DLL             = false)
  (avl_writedata,dqse_phase);

  input  [AVL_DATA_WIDTH-1:0] avl_writedata;
  output [3:0] dqse_phase;
  reg  [3:0] dqse_phase;

  
  generate
      if (USE_2X_DLL == true) 
        begin
          
          always @(*)
              begin : decode_2x
                dqse_phase = 4'b0111;
                case (avl_writedata[1+1:0])

                  3'b000: begin
                        dqse_phase = 4'b0100;
                      end

                  default: begin

                      end

                endcase

              end
        end
      else 
        begin
          
          always @(*)
              begin : decode
                dqse_phase = 4'b0110;
                case (avl_writedata[1+1:0])

                  3'b000: begin
                        dqse_phase = 4'b0010;
                      end

                  default: begin

                      end

                endcase

              end
        end
  endgenerate

endmodule

