
module ps2_controller(input  reset,
                      input  clk,
                      input  ps2_clock,
                      input  ps2_data,
                      output scan_ready,
                      output [7:0] scan_code);

  reg  [7:0] r_scan_code;
  reg  [3:0]  state_reg = 4'd0;
  reg  ready;
  reg  [1:0]  ps2_clock_edge_detect = 2'b00;
  wire ps2_clock_negedge;

  assign scan_code = r_scan_code;
  assign scan_ready = ready;
  assign ps2_clock_negedge = ps2_clock_edge_detect == 2'b10;
  
  always @(posedge clk)
      begin
        ps2_clock_edge_detect <= {ps2_clock_edge_detect[0],ps2_clock};
      end
  
  always @(posedge clk or posedge reset)
      begin
        if (reset) 
          begin
            state_reg <= 4'b0;
            r_scan_code <= 8'b0;
          end
        else if (ready) 
          begin
            ready <= 1'b0;
          end
        else if (ps2_clock_negedge) 
          begin
            case (state_reg)

              4'd0: begin
                    state_reg <= state_reg+1'b1;
                    ready <= 1'b0;
                  end

              4'd9: begin
                    if (!ps2_data == ^r_scan_code) 
                      begin
                        ready <= 1'b1;
                      end
                    else 
                      begin
                        ready <= 1'b0;
                      end
                    state_reg <= state_reg+1'b1;
                  end

              4'd10: begin
                    state_reg <= 4'b0;
                    ready <= 1'b0;
                  end

              default: begin
                    r_scan_code[(0-1)+state_reg] <= ps2_data;
                    state_reg <= state_reg+1'b1;
                    ready <= 1'b0;
                  end

            endcase

          end
          
      end
endmodule

