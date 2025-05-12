
module spi_cfg  #(parameter  CLK_DIV = 3, N_SLAVES = 4)
  (input  wire aclk,
   input  wire [32+(-1):0] s_axis_tdata,
   input  wire s_axis_tvalid,
   input  wire [8-1:0] cmd,
   output reg [(-1)+N_SLAVES:0] cs,
   output reg sclk,
   output reg sdi,
   output reg s_axis_tready);

  reg  [32+(-1):0] data_reg;
  reg  [8-1:0] cmd_reg;
  reg  [CLK_DIV-1:0]  cnt_clk = 0;
  reg  [6+(-1):0] cnt_sclk;
  reg  sclk_reg;
  reg  end_sequence;

  
  initial    s_axis_tready = 1'b1;
  
  initial    cs = {N_SLAVES{1'b1}};
  
  initial    end_sequence = 1'b0;
  
  always @(posedge aclk)
      begin
        cnt_clk <= 1+cnt_clk;
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
                        sdi <= data_reg[31-cnt_sclk];
                        if ((cmd_reg[3:1<<<1] == 2'b00) && (cnt_sclk == 7)) 
                          begin
                            end_sequence <= 1'b1;
                          end
                          
                      end
                    else if ((cnt_sclk < 16) && (cnt_sclk >= 8)) 
                      begin
                        sdi <= data_reg[31-cnt_sclk];
                        if ((cnt_sclk == 15) && (cmd_reg[3:1<<<1] == 2'b01)) 
                          begin
                            end_sequence <= 1'b1;
                          end
                          
                      end
                    else if ((cnt_sclk >= 16) && (cnt_sclk < 24)) 
                      begin
                        sdi <= data_reg[31-cnt_sclk];
                        if ((cmd_reg[3:1<<<1] == 2'b10) && (cnt_sclk == 23)) 
                          begin
                            end_sequence <= 1'b1;
                          end
                          
                      end
                    else if ((cnt_sclk < 32) && (cnt_sclk >= 24)) 
                      begin
                        sdi <= data_reg[31-cnt_sclk];
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
            else if (cnt_clk == {{1'b0},{CLK_DIV-1{1'b1}}}) 
              begin
                sclk_reg <= 1'b0;
                sclk <= sclk_reg;
              end
              
          end
        else 
          begin
            if (s_axis_tready && s_axis_tvalid) 
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

