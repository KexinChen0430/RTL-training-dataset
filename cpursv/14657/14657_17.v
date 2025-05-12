
module spi_cfg  #(parameter  CLK_DIV = 3, N_SLAVES = 4)
  (input  wire aclk,
   input  wire [32+(0-1):0] s_axis_tdata,
   input  wire s_axis_tvalid,
   input  wire [8-1:0] cmd,
   output reg [(0-1)+N_SLAVES:0] cs,
   output reg sclk,
   output reg sdi,
   output reg s_axis_tready);

  reg  [32+(0-1):0] data_reg;
  reg  [8-1:0] cmd_reg;
  reg  [CLK_DIV+(0-1):0]  cnt_clk = 0;
  reg  [(0-1)+6:0] cnt_sclk;
  reg  sclk_reg;
  reg  end_sequence;

  
  initial    s_axis_tready = 1'b1;
  
  initial    cs = {N_SLAVES{1'b1}};
  
  initial    end_sequence = 1'b0;
  
  always @(posedge aclk)
      begin
        cnt_clk <= cnt_clk+1;
        if (s_axis_tready == 1'b0) 
          begin
            if (cnt_clk == {CLK_DIV{1'b1}}) 
              begin
                cnt_sclk <= 1+cnt_sclk;
                sclk_reg <= 1'b1;
                sclk <= sclk_reg;
                if (end_sequence == 0) 
                  begin
                    if (cnt_sclk < 8) 
                      begin
                        sdi <= data_reg[(0-cnt_sclk)+31];
                        if ((cmd_reg[3:2] == 2'b00) && (cnt_sclk == 7)) 
                          begin
                            end_sequence <= 1'b1;
                          end
                          
                      end
                    else if ((cnt_sclk >= 8) && (cnt_sclk < 16)) 
                      begin
                        sdi <= data_reg[(0-cnt_sclk)+31];
                        if ((cmd_reg[3:2] == 2'b01) && (cnt_sclk == 15)) 
                          begin
                            end_sequence <= 1'b1;
                          end
                          
                      end
                    else if ((cnt_sclk >= 16) && (cnt_sclk < 24)) 
                      begin
                        sdi <= data_reg[(0-cnt_sclk)+31];
                        if ((cmd_reg[3:2] == 2'b10) && (cnt_sclk == 23)) 
                          begin
                            end_sequence <= 1'b1;
                          end
                          
                      end
                    else if ((cnt_sclk >= 24) && (cnt_sclk < 32)) 
                      begin
                        sdi <= data_reg[(0-cnt_sclk)+31];
                        if (cnt_sclk == 31) 
                          begin
                            end_sequence <= 1'b1;
                          end
                          
                      end
                      
                  end
                else 
                  begin
                    sdi <= 0;
                    sclk_reg <= 1'b0;
                    cs <= {N_SLAVES{1'b1}};
                    s_axis_tready <= 1'b1;
                    end_sequence <= 1'b0;
                  end
              end
            else if (cnt_clk == {{1'b0},{CLK_DIV+(0-1){1'b1}}}) 
              begin
                sclk_reg <= 1'b0;
                sclk <= sclk_reg;
              end
              
          end
        else 
          begin
            if (s_axis_tvalid && s_axis_tready) 
              begin
                cs[cmd[1:0]] <= 0;
                s_axis_tready <= 0;
                cmd_reg <= cmd;
                data_reg <= s_axis_tdata;
                cnt_clk <= 0;
                cnt_sclk <= 0;
                sclk_reg <= 0;
                sclk <= 0;
              end
              
          end
      end
endmodule

