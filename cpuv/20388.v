module FIFO F0 (
  .m_aclk(m_aclk), 
  .s_aclk(s_aclk), 
  .s_aresetn(s_aresetn), 
  .s_axis_tvalid(s_axis_tvalid), 
  .s_axis_tready(s_axis_tready), 
  .s_axis_tdata(s_axis_tdata), 
  .s_axis_tkeep(s_axis_tkeep), 
  .s_axis_tlast(s_axis_tlast), 
  .m_axis_tvalid(m_axis_tvalid), 
  .m_axis_tready(m_axis_tready), 
  .m_axis_tdata(m_axis_tdata), 
  .m_axis_tkeep(m_axis_tkeep), 
  .m_axis_tlast(m_axis_tlast), 
  .axis_overflow(axis_overflow), 
  .axis_underflow(axis_underflow) 
);
always @(m_axis_tvalid) begin
  m_axis_tready <= m_axis_tvalid;
end
initial begin
  s_aclk            <= 1'b0; 
  m_aclk            <= 1'b0; 
  s_aresetn         <= 1'b0; 
  s_axis_tvalid     <= 1'b0; 
  m_axis_tready     <= 1'b0; 
  s_axis_tdata      <= 64'b0; 
  s_axis_tkeep      <= 8'b0; 
  s_axis_tlast      <= 1'b0; 
end
initial begin
  forever begin
    #10 s_aclk <= ~s_aclk; 
  end
end
initial begin
  forever begin
    #5 m_aclk <= ~m_aclk; 
  end
end
initial begin
  #10 s_aresetn     <= 1'b1;  
  #60 s_axis_tvalid <= 1'b1;  
  s_axis_tdata      <= 64'hFFFFFFFFFFFFFFFF; 
  s_axis_tkeep      <= 8'hCF; 
  s_axis_tlast      <= 1'b1;  
  #20 s_axis_tvalid <= 1'b0;  
  s_axis_tdata      <= 64'b0; 
  s_axis_tkeep      <= 8'b0;  
  s_axis_tlast      <= 1'b0;  
  #20 s_axis_tvalid <= 1'b1;  
  s_axis_tdata      <= 64'h1111111111111111; 
  s_axis_tkeep      <= 8'hFF; 
  #20 s_axis_tdata  <= 64'h2222222222222222; 
  s_axis_tkeep      <= 8'hFF; 
  #20 s_axis_tdata  <= 64'h3333333333333333; 
  s_axis_tkeep      <= 8'hFF; 
  #20 s_axis_tdata  <= 64'h4444444444444444; 
  s_axis_tkeep      <= 8'hFF; 
  s_axis_tlast      <= 1'b1;  
  #20 s_axis_tvalid <= 1'b0;  
  s_axis_tdata      <= 64'b0; 
  s_axis_tkeep      <= 8'b0;  
  s_axis_tlast      <= 1'b0;  
end
endmodule 