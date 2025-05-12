
module splitter(input  clk,
                input  resetn,
                input  s_valid,
                output s_ready,
                output [(-1)+C_NUM_M:0] m_valid,
                input  [(-1)+C_NUM_M:0] m_ready);

  parameter  C_NUM_M = 1<<1;
  reg  [(-1)+C_NUM_M:0] acked;

  assign s_ready = &(acked | m_ready);
  assign m_valid = s_valid ? ~acked : {C_NUM_M{1'b0}};
  
  always @(posedge clk)
      begin
        if (resetn == 1'b0) 
          begin
            acked <= {C_NUM_M{1'b0}};
          end
        else 
          begin
            if (s_ready & s_valid) acked <= {C_NUM_M{1'b0}};
            else acked <= (acked | m_ready) & (acked | m_valid);
          end
      end
endmodule

