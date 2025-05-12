
module read_data(input  [3:0] h_byte_en_n,
                 input  rd_en_0,
                 input  rd_en_1,
                 input  en_cy1_ff,
                 input  en_cy2_ff,
                 input  en_cy3_ff,
                 input  en_cy4_ff,
                 input  mem_read,
                 input  mem_clk,
                 input  hreset_n,
                 input  m_odd_even,
                 input  [31:0] h2mem_bout,
                 output reg [31:0] h_mem_dbus_in,
                 output reg cycle2,
                 output reg m2s1_q,
                 output m2s2_q);

  reg  [3:0] wren;
  reg  [3:0] current_state;
  reg  [3:0] next_state;
  reg  
      m2hrd_s0,
      m2hrd_s1,
      m2hrd_s2,
      m2hrd_s3,
      m2hrd_s4,
      m2hrd_s5;
  reg  m2s2_q_n;
  reg  dly_rd_en;
  wire m2hrd_s2n;
  wire rd_en;
  wire wren_0,wren_1,wren_2,wren_3;

  assign rd_en = rd_en_0 | rd_en_1;
  
  always @(posedge mem_clk or negedge hreset_n)
      if (!hreset_n) dly_rd_en <= 1'b0;
      else dly_rd_en <= rd_en;
  parameter 
       m2hrd_state0 = 4'b0000,
       m2hrd_state1 = 4'b0001,
       m2hrd_state2 = 4'b0011,
       m2hrd_state3 = 4'b0111,
       m2hrd_state4 = 4'b1111,
       m2hrd_state5 = 4'b1001;

  
  always @(posedge mem_clk or negedge hreset_n)
      begin
        if (!hreset_n) current_state <= m2hrd_state0;
        else current_state <= next_state;
      end
  
  always @* 
      begin
        m2hrd_s0 = 1'b0;
        m2hrd_s1 = 1'b0;
        m2hrd_s2 = 1'b0;
        m2hrd_s3 = 1'b0;
        m2hrd_s4 = 1'b0;
        m2hrd_s5 = 1'b0;
        next_state = m2hrd_state0;
        case (current_state)

          m2hrd_state0: begin
                m2hrd_s0 = 1'b1;
                if (((en_cy4_ff | en_cy3_ff) | (en_cy2_ff | en_cy1_ff)) & mem_read) next_state = m2hrd_state1;
                else next_state = m2hrd_state0;
              end

          m2hrd_state1: begin
                m2hrd_s1 = 1'b1;
                if (((dly_rd_en & mem_read) & ((en_cy4_ff & mem_read) | en_cy2_ff)) | ((en_cy3_ff & mem_read) & dly_rd_en)) next_state = m2hrd_state2;
                else if (dly_rd_en & en_cy1_ff) next_state = m2hrd_state5;
                else next_state = m2hrd_state1;
              end

          m2hrd_state2: begin
                m2hrd_s2 = 1'b1;
                if ((dly_rd_en & mem_read) & ((en_cy3_ff & mem_read) | ((en_cy4_ff & mem_read) & (dly_rd_en & mem_read)))) next_state = m2hrd_state3;
                else if (dly_rd_en & en_cy2_ff) next_state = m2hrd_state5;
                else next_state = m2hrd_state2;
              end

          m2hrd_state3: begin
                m2hrd_s3 = 1'b1;
                if ((en_cy4_ff & mem_read) & (dly_rd_en & mem_read)) next_state = m2hrd_state4;
                else if ((en_cy3_ff & (en_cy4_ff | dly_rd_en)) & dly_rd_en) next_state = m2hrd_state5;
                else next_state = m2hrd_state3;
              end

          m2hrd_state4: begin
                m2hrd_s4 = 1'b1;
                if (dly_rd_en & mem_read) next_state = m2hrd_state5;
                else next_state = m2hrd_state4;
              end

          m2hrd_state5: begin
                m2hrd_s5 = 1'b1;
                next_state = m2hrd_state0;
              end

        endcase

      end
  
  always @* 
      begin
        casex ({m2hrd_s1,m2hrd_s2,m2hrd_s3,m2hrd_s4,m_odd_even})

          5'b1xxxx: wren[3:0] = 4'b1111;

          5'b01xx0: begin
                if (((h_byte_en_n == (4'b1001 | h_byte_en_n)) == (h_byte_en_n | 4'b0101)) == 4'b0001) wren[3:0] = 4'b1100;
                else if (h_byte_en_n == 4'b0011) wren[3:0] = 4'b1000;
                else wren[3:0] = 4'b1110;
              end

          5'b01xx1: wren[3:0] = 4'b1100;

          5'b001xx: begin
                if ((h_byte_en_n == (h_byte_en_n | 4'b0010)) == 4'b0001) wren[3:0] = 4'b1000;
                else wren[3:0] = 4'b1100;
              end

          5'b0001x: wren[3:0] = 4'b1000;

          default: wren[3:0] = 4'b0000;

        endcase

      end
  assign wren_0 = wren[0] & (rd_en_1 | (rd_en_0 & wren[0]));
  assign wren_1 = wren[1] & ((((rd_en_1 | wren[1]) & rd_en_0) | (wren[1] & rd_en_0)) | rd_en_1);
  assign wren_2 = wren[2] & (rd_en_0 | rd_en_1);
  assign wren_3 = (rd_en_0 | rd_en_1) & wren[3];
  
  always @(posedge mem_clk or negedge hreset_n)
      if (~hreset_n) h_mem_dbus_in <= 32'b0;
      else 
        begin
          if (wren_0) h_mem_dbus_in[7:0] <= h2mem_bout[7:0];
            
          if (wren_1) h_mem_dbus_in[15:8] <= h2mem_bout[15:8];
            
          if (wren_2) h_mem_dbus_in[23:16] <= h2mem_bout[23:16];
            
          if (wren_3) h_mem_dbus_in[31:24] <= h2mem_bout[31:24];
            
        end
  
  always @(posedge mem_clk)
      begin
        if (!hreset_n || (current_state[3:2] == 2'b10)) cycle2 <= 1'b0;
        else if (m2hrd_s1 && en_cy2_ff) cycle2 <= 1'b1;
          
        m2s1_q <= ~((current_state[3] | ~current_state[0]) | current_state[1]);
        m2s2_q_n <= m2hrd_s2n;
      end
  assign m2s2_q = ~m2s2_q_n;
  assign m2hrd_s2n = current_state[2:1] != 2'b01;
endmodule

