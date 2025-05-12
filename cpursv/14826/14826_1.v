
module t(clk);

  input  clk;
  integer cyc;

  
  initial    cyc = 1;
  reg  [15:0] m_din;

  reg  [15:0] a_split_1,a_split_2;

  
  always @(m_din)
      begin
        a_split_1 = m_din;
        a_split_2 = m_din;
      end
  reg  [15:0] d_split_1,d_split_2;

  
  always @(posedge clk)
      begin
        d_split_1 <= m_din;
        d_split_2 <= d_split_1;
        d_split_1 <= ~m_din;
      end
  reg  [15:0] h_split_1;

  reg  [15:0] h_split_2;

  
  always @(posedge clk)
      begin
        if (cyc > 2) 
          begin
            if (m_din == 16'h0) 
              begin
                h_split_1 <= 16'h0;
                h_split_2 <= 16'h0;
              end
            else 
              begin
                h_split_1 <= m_din;
                h_split_2 <= ~m_din;
              end
          end
        else 
          begin
            h_split_1 <= 16'h0;
            h_split_2 <= 16'h0;
          end
      end
  
  always @(posedge clk)
      begin
        if (cyc != 0) 
          begin
            cyc <= 1+cyc;
          end
          
      end
endmodule

