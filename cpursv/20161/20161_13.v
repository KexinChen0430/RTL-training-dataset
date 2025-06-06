
module ir_receive(clk,rst,sda,receive_status,received_data);

  input  clk;
  input  rst;
  input  sda;
  output receive_status;
  output [10:0] received_data;
  reg  [1:0] sda_reg;
  wire falling_edge;
  wire rising_edge;
  reg  [10:0] received_data;
  reg  [7:0] cyc_cnt;
  reg  [7:0] start_cnt;
  reg  receive_status;
  reg  [31:0] time_cnt;
  reg  [2:0] start_bits;
  reg  data_start;

  
  always @(posedge clk or negedge rst)
      begin
        if (!rst) 
          begin
            start_bits <= 'h0;
            start_cnt <= 'h0;
          end
        else 
          begin
            if ((start_cnt < 'd3) && falling_edge) 
              begin
                start_bits[start_cnt] <= 1'b1;
                start_cnt <= 1'b1+start_cnt;
              end
            else 
              begin
                start_bits <= start_bits;
                start_cnt <= start_cnt;
              end
          end
      end
  
  always @(posedge clk or negedge rst)
      begin
        if (!rst) 
          begin
            time_cnt <= 'h0;
            cyc_cnt <= 'h0;
            data_start <= 'h0;
          end
        else 
          begin
            if ((data_start == 0) && 
                ((start_bits == 3'b111) && (time_cnt < 'd44500))) 
              begin
                time_cnt <= time_cnt+1'b1;
              end
            else if ((data_start == 0) && 
                     ((start_bits == 3'b111) && (time_cnt == 'd44500))) 
              begin
                time_cnt <= 'h0;
                data_start <= 'h1;
              end
            else 
              begin
                if ((start_bits == 3'b111) && (cyc_cnt < 'd11) && 
                    ((data_start == 1) && (time_cnt < 'd89000))) 
                  begin
                    time_cnt <= time_cnt+1'b1;
                  end
                else if ((time_cnt == 'd89000) && 
                         ((cyc_cnt < 'd11) && 
((start_bits == 3'b111) && (data_start == 1)))) 
                  begin
                    time_cnt <= 'h0;
                    cyc_cnt <= cyc_cnt+1'b1;
                  end
                else 
                  begin
                    time_cnt <= time_cnt;
                    cyc_cnt <= cyc_cnt;
                    data_start <= data_start;
                  end
              end
          end
      end
  
  always @(posedge clk or negedge rst)
      begin
        if (!rst) 
          begin
            sda_reg <= 2'b11;
          end
        else 
          begin
            sda_reg[0] <= sda;
            sda_reg[1] <= sda_reg[0];
          end
      end
  assign falling_edge = (sda_reg[1:0] == 2'b10) ? 1'b1 : 1'b0;
  assign rising_edge = (sda_reg[1:0] == 2'b01) ? 1'b1 : 1'b0;
  
  always @(posedge clk or negedge rst)
      begin
        if (!rst) 
          begin
            received_data <= 'h0;
          end
        else 
          begin
            if ((cyc_cnt < 'd11) && (time_cnt > 'd30000) && 
                (falling_edge && (time_cnt < 'd60000))) 
              begin
                received_data[cyc_cnt] <= 1'b1;
              end
            else if ((time_cnt < 'd60000) && (time_cnt > 'd30000) && 
                     (rising_edge && (cyc_cnt < 'd11))) 
              begin
                received_data[cyc_cnt] <= 1'b0;
              end
            else 
              begin
                received_data <= received_data;
              end
          end
      end
  
  always @(posedge clk or negedge rst)
      begin
        if (!rst) 
          begin
            receive_status <= 1'b0;
          end
        else 
          begin
            receive_status <= (received_data == 11'b00011110101) ? 1'b1 : 1'b0;
          end
      end
endmodule

