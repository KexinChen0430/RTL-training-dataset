
module during_idle_run_state;

  assign main_count_rollover = main_count == measurement;
  assign baud_clk_o = main_count_rollover && run;
  
  always @(posedge clk_i or posedge reset_i)
      begin : m1_state_register
        if (reset_i) m1_state <= m1_idle;
        else m1_state <= m1_next_state;
      end
  
  always @(m1_state or mid_bit_count or serial_dat_i or verify_done or character_miscompare)
      begin : m1_state_logic
        idle <= 1'b0;
        run <= 1'b0;
        measure <= 1'b0;
        clear_counters <= 1'b0;
        verify <= 1'b0;
        case (m1_state)

          m1_idle: begin
                idle <= 1'b1;
                if (serial_dat_i == 0) m1_next_state <= m1_measure_0;
                else m1_next_state <= m1_idle;
              end

          m1_measure_0: begin
                measure <= 1'b1;
                if (mid_bit_count && ~serial_dat_i) m1_next_state <= m1_measure_1;
                else if (mid_bit_count && serial_dat_i) m1_next_state <= m1_idle;
                else m1_next_state <= m1_measure_0;
              end

          m1_measure_1: begin
                measure <= 1'b1;
                if (serial_dat_i) m1_next_state <= m1_measure_2;
                else m1_next_state <= m1_measure_1;
              end

          m1_measure_2: begin
                measure <= 1'b1;
                if (mid_bit_count && serial_dat_i) m1_next_state <= m1_measure_3;
                else if (mid_bit_count && ~serial_dat_i) m1_next_state <= m1_idle;
                else m1_next_state <= m1_measure_2;
              end

          m1_measure_3: begin
                measure <= 1'b1;
                if (!serial_dat_i) m1_next_state <= m1_measure_4;
                else m1_next_state <= m1_measure_3;
              end

          m1_measure_4: begin
                clear_counters <= 1'b1;
                m1_next_state <= m1_verify_0;
              end

          m1_verify_0: begin
                verify <= 1'b1;
                if (verify_done) m1_next_state <= m1_verify_1;
                else m1_next_state <= m1_verify_0;
              end

          m1_verify_1: begin
                if (character_miscompare) m1_next_state <= m1_verify_failed;
                else m1_next_state <= m1_run;
              end

          m1_verify_failed: begin
                clear_counters <= 1'b1;
                m1_next_state <= m1_idle;
              end

          m1_run: begin
                run <= 1'b1;
                m1_next_state <= m1_run;
              end

          default: m1_next_state <= m1_idle;

        endcase

      end
  assign auto_baud_locked_o = run;
endmodule

