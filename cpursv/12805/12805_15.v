
module util_axis_resize(input  clk,
                        input  resetn,
                        input  s_valid,
                        output s_ready,
                        input  [(-1)+C_S_DATA_WIDTH:0] s_data,
                        output m_valid,
                        input  m_ready,
                        output [(-1)+C_M_DATA_WIDTH:0] m_data);

  parameter  C_M_DATA_WIDTH = 64;
  parameter  C_S_DATA_WIDTH = 64;
  parameter  C_BIG_ENDIAN = 0;

  
  generate
      if (C_S_DATA_WIDTH == C_M_DATA_WIDTH) 
        begin
          assign m_valid = s_valid;
          assign s_ready = m_ready;
          assign m_data = s_data;
        end
      else if (C_S_DATA_WIDTH < C_M_DATA_WIDTH) 
        begin
          localparam  RATIO = (1/C_S_DATA_WIDTH)*C_M_DATA_WIDTH;

          reg  [(-1)+C_M_DATA_WIDTH:0] data;

          reg  [(-1)+$clog2(RATIO):0] count;

          reg  valid;

          
          always @(posedge clk)
              begin
                if (resetn == 1'b0) 
                  begin
                    count <= RATIO+(-1);
                    valid <= 1'b0;
                  end
                else 
                  begin
                    if ((s_valid == 1'b1) && (s_ready == 1'b1) && (count == 'h00)) valid <= 1'b1;
                    else if (m_ready == 1'b1) valid <= 1'b0;
                      
                    if ((s_valid == 1'b1) && (s_ready == 1'b1)) 
                      begin
                        if (count == 'h00) count <= RATIO+(-1);
                        else count <= count-1'b1;
                      end
                      
                  end
              end
          
          always @(posedge clk)
              begin
                if ((s_valid == 1'b1) && (s_ready == 1'b1)) 
                  if (C_BIG_ENDIAN == 1) 
                    begin
                      data <= {data[C_M_DATA_WIDTH+((-1)+(-C_S_DATA_WIDTH)):0],s_data};
                    end
                  else 
                    begin
                      data <= {s_data,data[(-1)+C_M_DATA_WIDTH:C_S_DATA_WIDTH]};
                    end
                  
              end
          assign s_ready = ~valid || m_ready;
          assign m_valid = valid;
          assign m_data = data;
        end
      else 
        begin
          localparam  RATIO = (1/C_M_DATA_WIDTH)*C_S_DATA_WIDTH;

          reg  [(-1)+C_S_DATA_WIDTH:0] data;

          reg  [(-1)+$clog2(RATIO):0] count;

          reg  valid;

          
          always @(posedge clk)
              begin
                if (resetn == 1'b0) 
                  begin
                    count <= RATIO+(-1);
                    valid <= 1'b0;
                  end
                else 
                  begin
                    if ((s_valid == 1'b1) && (s_ready == 1'b1)) valid <= 1'b1;
                    else if ((m_ready == 1'b1) && 
                             (~valid || m_ready || (count == 'h0)) && (count == 'h0) && (m_valid == 1'b1)) valid <= 1'b0;
                      
                    if ((m_ready == 1'b1) && (m_valid == 1'b1)) 
                      begin
                        if (count == 'h00) count <= RATIO+(-1);
                        else count <= count-1'b1;
                      end
                      
                  end
              end
          
          always @(posedge clk)
              begin
                if ((s_valid == 1'b1) && (s_ready == 1'b1)) 
                  begin
                    data <= s_data;
                  end
                else if ((m_ready == 1'b1) && (m_valid == 1'b1)) 
                  begin
                    if (C_BIG_ENDIAN == 1) 
                      begin
                        data[(-1)+C_S_DATA_WIDTH:C_M_DATA_WIDTH] <= data[((-1)+C_S_DATA_WIDTH)+(0-C_M_DATA_WIDTH):0];
                      end
                    else 
                      begin
                        data[((-1)+C_S_DATA_WIDTH)+(0-C_M_DATA_WIDTH):0] <= data[(-1)+C_S_DATA_WIDTH:C_M_DATA_WIDTH];
                      end
                  end
                  
              end
          assign s_ready = ~valid || ((count == 'h0) && m_ready);
          assign m_valid = valid;
          assign m_data = (C_BIG_ENDIAN == 1) ? data[(-1)+C_S_DATA_WIDTH:C_S_DATA_WIDTH-C_M_DATA_WIDTH] : data[(-1)+C_M_DATA_WIDTH:0];
        end
  endgenerate

endmodule

