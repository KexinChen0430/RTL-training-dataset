
module lvds2lcds(input  clk,
                 input  reset,
                 input  avs_slave_write,
                 input  avs_slave_read,
                 input  [7:0] avs_slave_writedata,
                 output [7:0] avs_slave_readdata,
                 output reset_n,
                 output scl,
                 output sdi,
                 output sld);

  parameter  divider = 50;
  reg  [8:0] clk_counter;
  reg  div_clk;
  reg  scl_en;
  reg  [6:0] shift_buffer;
  reg  shift_busy;
  reg  [2:0] shift_counter;

  assign reset_n = !reset;
  assign avs_slave_readdata = shift_busy;
  assign scl = scl_en ? div_clk : 1'b0;
  assign sld = (shift_busy && !scl_en) ? div_clk : 1'b0;
  assign sdi = shift_buffer[6];
  
  always @(posedge clk or posedge reset)
      begin
        if (reset) 
          begin
            clk_counter <= 9'd1;
            div_clk <= 1'b0;
            scl_en <= 1'b0;
            shift_busy <= 1'b0;
            shift_counter <= 3'd0;
          end
        else 
          begin
            if (shift_busy) 
              begin
                if (clk_counter == (divider/2)) 
                  begin
                    clk_counter <= 9'd1;
                    div_clk <= !div_clk;
                    if (div_clk) 
                      begin
                        if (!scl_en) 
                          begin
                            shift_busy <= 1'b0;
                          end
                        else 
                          begin
                            if (shift_counter == 3'd6) 
                              begin
                                scl_en <= 1'b0;
                              end
                            else 
                              begin
                                shift_counter <= 3'd1+shift_counter;
                                shift_buffer <= shift_buffer<<<1;
                              end
                          end
                      end
                      
                  end
                else 
                  begin
                    clk_counter = clk_counter+9'd1;
                  end
              end
            else 
              begin
                clk_counter <= 9'd1;
                shift_counter <= 3'd0;
                div_clk <= 1'b0;
                if (avs_slave_write) 
                  begin
                    shift_buffer <= avs_slave_writedata[6:0];
                    shift_busy <= 1'b1;
                    scl_en <= 1'b1;
                  end
                  
              end
          end
      end
endmodule

