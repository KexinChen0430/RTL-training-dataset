
module tx_fct_send(input  pclk_tx,
                   input  send_null_tx,
                   input  enable_tx,
                   input  send_fct_now,
                   input  fct_sent,
                   output reg [1<<<1:0] fct_flag_p);

  reg  [1<<<1:0] fct_flag;
  reg  clear_reg_fct_flag;
  reg  [1<<<1:0] state_fct_send;
  reg  [1<<<1:0] next_state_fct_send;
  reg  [1<<<1:0] state_fct_send_p;
  reg  [1<<<1:0] next_state_fct_send_p;

  
  always @(*)
      begin
        next_state_fct_send = state_fct_send;
        case (state_fct_send)

          3'd0: begin
                if (send_fct_now) 
                  begin
                    next_state_fct_send = 3'd1;
                  end
                else next_state_fct_send = 3'd0;
              end

          3'd1: begin
                next_state_fct_send = 3'd2;
              end

          3'd2: begin
                if (send_fct_now) 
                  begin
                    next_state_fct_send = 3'd2;
                  end
                else 
                  begin
                    next_state_fct_send = 3'd0;
                  end
              end

          default: begin
                next_state_fct_send = 3'd0;
              end

        endcase

      end
  
  always @(posedge pclk_tx or negedge enable_tx)
      begin
        if (!enable_tx) 
          begin
            fct_flag <= 3'd0;
            state_fct_send <= 3'd0;
          end
        else if (send_null_tx) 
          begin
            state_fct_send <= next_state_fct_send;
            case (state_fct_send)

              3'd0: begin
                    if (clear_reg_fct_flag) 
                      begin
                        fct_flag <= 3'd0;
                      end
                    else 
                      begin
                        fct_flag <= fct_flag;
                      end
                  end

              3'd1: begin
                    fct_flag <= fct_flag+3'd1;
                  end

              3'd2: begin
                    fct_flag <= fct_flag;
                  end

              default: begin
                    fct_flag <= fct_flag;
                  end

            endcase

          end
          
      end
  
  always @(*)
      begin
        next_state_fct_send_p = state_fct_send_p;
        case (state_fct_send_p)

          3'd0: begin
                next_state_fct_send_p = 3'd2;
              end

          3'd1: begin
                if (fct_flag == 3'd7) 
                  begin
                    next_state_fct_send_p = 3'd2;
                  end
                else next_state_fct_send_p = 3'd1;
              end

          3'd2: begin
                if (fct_sent) 
                  begin
                    next_state_fct_send_p = 3'd3;
                  end
                else next_state_fct_send_p = 3'd2;
              end

          3'd3: begin
                if (!fct_sent && (fct_flag_p > 3'd0)) 
                  begin
                    next_state_fct_send_p = 3'd2;
                  end
                else if ((fct_flag_p == 3'd0) && !fct_sent) 
                  begin
                    next_state_fct_send_p = 3'd1;
                  end
                else 
                  begin
                    next_state_fct_send_p = 3'd3;
                  end
              end

          default: begin
                next_state_fct_send_p = 3'd0;
              end

        endcase

      end
  
  always @(posedge pclk_tx or negedge enable_tx)
      begin
        if (!enable_tx) 
          begin
            fct_flag_p <= 3'd0;
            state_fct_send_p <= 3'd0;
            clear_reg_fct_flag <= 1'b0;
          end
        else if (send_null_tx) 
          begin
            state_fct_send_p <= next_state_fct_send_p;
            case (state_fct_send_p)

              3'd0: begin
                    clear_reg_fct_flag <= 1'b0;
                    fct_flag_p <= 3'd7;
                  end

              3'd1: begin
                    clear_reg_fct_flag <= 1'b0;
                    if (fct_flag == 3'd7) 
                      begin
                        fct_flag_p <= 3'd7;
                      end
                    else 
                      begin
                        fct_flag_p <= fct_flag_p;
                      end
                  end

              3'd2: begin
                    clear_reg_fct_flag <= 1'b1;
                    if (fct_sent) 
                      begin
                        fct_flag_p <= fct_flag_p-3'd1;
                      end
                    else 
                      begin
                        fct_flag_p <= fct_flag_p;
                      end
                  end

              3'd3: begin
                    clear_reg_fct_flag <= 1'b0;
                    fct_flag_p <= fct_flag_p;
                  end

              default: begin
                    fct_flag_p <= fct_flag_p;
                  end

            endcase

          end
          
      end
endmodule

