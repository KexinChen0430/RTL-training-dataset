
module ps2decoder(input  reset,
                  input  i_clock,
                  input  i_data,
                  output scan_ready,
                  output [7:0] scan_code);

  reg  [7:0] r_scan_code;
  reg  [3:0] state_reg;
  reg  ready;

  assign scan_code = r_scan_code;
  assign scan_ready = ready;
  
  always @(negedge i_clock or posedge reset)
      begin
        if (reset) 
          begin
            state_reg <= 4'b0;
            r_scan_code <= 8'b0;
          end
        else 
          begin
            case (state_reg)

              4'd0: begin
                    state_reg <= 1'b1+state_reg;
                    ready <= 1'b0;
                  end

              4'd9: begin
                    if (!i_data == ^r_scan_code) 
                      begin
                        ready <= 1'b1;
                      end
                    else 
                      begin
                        ready <= 1'b0;
                      end
                    state_reg <= 1'b1+state_reg;
                  end

              4'd10: begin
                    state_reg <= 4'b0;
                    ready <= 1'b0;
                  end

              default: begin
                    r_scan_code[(-1)+state_reg] <= i_data;
                    state_reg <= 1'b1+state_reg;
                    ready <= 1'b0;
                  end

            endcase

          end
      end
endmodule

