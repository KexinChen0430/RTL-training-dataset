
module splitter  #(parameter  NUM_M = 1<<<1)
  (input  clk,
   input  resetn,
   input  s_valid,
   output s_ready,
   output [(-1)+NUM_M:0] m_valid,
   input  [(-1)+NUM_M:0] m_ready);

  reg  [(-1)+NUM_M:0] acked;

  assign s_ready = &(m_ready | acked);
  assign m_valid = s_valid ? ~acked : {NUM_M{1'b0}};
  
  always @(posedge clk)
      begin
        if (resetn == 1'b0) 
          begin
            acked <= {NUM_M{1'b0}};
          end
        else 
          begin
            if (s_valid & s_ready) acked <= {NUM_M{1'b0}};
            else acked <= ((m_ready | acked) & m_valid) | acked;
          end
      end
endmodule

