
module prometheus_fx3_stream_out(input  rst_n,
                                 input  clk_100,
                                 input  stream_out_mode_selected,
                                 input  i_gpif_in_ch1_rdy_d,
                                 input  i_gpif_out_ch1_rdy_d,
                                 input  [31:0] stream_out_data_from_fx3,
                                 output o_gpif_re_n_stream_out_,
                                 output o_gpif_oe_n_stream_out_);

  reg  [1<<1:0] current_stream_out_state;
  reg  [1<<1:0] next_stream_out_state;
  parameter [1<<1:0]  stream_out_idle = 3'd0;
  parameter [1<<1:0]  stream_out_flagc_rcvd = 3'd1;
  parameter [1<<1:0]  stream_out_wait_flagd = 3'd2;
  parameter [1<<1:0]  stream_out_read = 3'd3;
  parameter [1<<1:0]  stream_out_read_rd_and_oe_delay = 3'd4;
  parameter [1<<1:0]  stream_out_read_oe_delay = 3'd5;
  reg  [1:0] oe_delay_cnt;
  reg  rd_oe_delay_cnt;

  assign o_gpif_re_n_stream_out_ = ((current_stream_out_state == stream_out_read_rd_and_oe_delay) | (current_stream_out_state == stream_out_read)) ? 1'b0 : 1'b1;
  assign o_gpif_oe_n_stream_out_ = ((current_stream_out_state == stream_out_read_rd_and_oe_delay) | ((current_stream_out_state == stream_out_read_oe_delay) | (current_stream_out_state == stream_out_read))) ? 1'b0 : 1'b1;
  
  always @(posedge clk_100 or negedge rst_n)
      begin
        if (!rst_n) 
          begin
            rd_oe_delay_cnt <= 1'b0;
          end
        else if (current_stream_out_state == stream_out_read) 
          begin
            rd_oe_delay_cnt <= 1'b1;
          end
        else if ((current_stream_out_state == stream_out_read_rd_and_oe_delay) & (rd_oe_delay_cnt > 1'b0)) 
          begin
            rd_oe_delay_cnt <= rd_oe_delay_cnt+(0-1'b1);
          end
        else 
          begin
            rd_oe_delay_cnt <= rd_oe_delay_cnt;
          end
      end
  
  always @(posedge clk_100 or negedge rst_n)
      begin
        if (!rst_n) 
          begin
            oe_delay_cnt <= 2'd0;
          end
        else if (current_stream_out_state == stream_out_read_rd_and_oe_delay) 
          begin
            oe_delay_cnt <= 2'd2;
          end
        else if ((oe_delay_cnt > 1'b0) & (current_stream_out_state == stream_out_read_oe_delay)) 
          begin
            oe_delay_cnt <= oe_delay_cnt-1'b1;
          end
        else 
          begin
            oe_delay_cnt <= oe_delay_cnt;
          end
      end
  
  always @(posedge clk_100 or negedge rst_n)
      begin
        if (!rst_n) 
          begin
            current_stream_out_state <= stream_out_idle;
          end
        else 
          begin
            current_stream_out_state <= next_stream_out_state;
          end
      end
  
  always @(*)
      begin
        next_stream_out_state = current_stream_out_state;
        case (current_stream_out_state)

          stream_out_idle: begin
                if (stream_out_mode_selected & (i_gpif_in_ch1_rdy_d == 1'b1)) 
                  begin
                    next_stream_out_state = stream_out_flagc_rcvd;
                  end
                else 
                  begin
                    next_stream_out_state = stream_out_idle;
                  end
              end

          stream_out_flagc_rcvd: begin
                next_stream_out_state = stream_out_wait_flagd;
              end

          stream_out_wait_flagd: begin
                if (i_gpif_out_ch1_rdy_d == 1'b1) 
                  begin
                    next_stream_out_state = stream_out_read;
                  end
                else 
                  begin
                    next_stream_out_state = stream_out_wait_flagd;
                  end
              end

          stream_out_read: begin
                if (i_gpif_out_ch1_rdy_d == 1'b0) 
                  begin
                    next_stream_out_state = stream_out_read_rd_and_oe_delay;
                  end
                else 
                  begin
                    next_stream_out_state = stream_out_read;
                  end
              end

          stream_out_read_rd_and_oe_delay: begin
                if (rd_oe_delay_cnt == 0) 
                  begin
                    next_stream_out_state = stream_out_read_oe_delay;
                  end
                else 
                  begin
                    next_stream_out_state = stream_out_read_rd_and_oe_delay;
                  end
              end

          stream_out_read_oe_delay: begin
                if (oe_delay_cnt == 0) 
                  begin
                    next_stream_out_state = stream_out_idle;
                  end
                else 
                  begin
                    next_stream_out_state = stream_out_read_oe_delay;
                  end
              end

        endcase

      end
endmodule

