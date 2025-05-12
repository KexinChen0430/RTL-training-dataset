module n64_vinfo_ext(
  VCLK,       
  nDSYNC,     
  Sync_pre,   
  Sync_cur,   
  vinfo_o     
);
`include "vh/n64rgb_params.vh"
input VCLK;
input nDSYNC;
input  [3:0] Sync_pre;
input  [3:0] Sync_cur;
output [3:0] vinfo_o;   
wire posedge_nVSYNC = !Sync_pre[3] &  Sync_cur[3]; 
wire negedge_nVSYNC =  Sync_pre[3] & !Sync_cur[3]; 
wire posedge_nHSYNC = !Sync_pre[1] &  Sync_cur[1]; 
wire negedge_nHSYNC =  Sync_pre[1] & !Sync_cur[1]; 
reg [1:0] data_cnt = 2'b00; 
always @(posedge VCLK) begin 
  if (!nDSYNC)
    data_cnt <= 2'b01;  
  else
    data_cnt <= data_cnt + 1'b1;  
end
reg FrameID  = 1'b0; 
reg n64_480i = 1'b1; 
always @(posedge VCLK) begin
  if (!nDSYNC) begin
    if (negedge_nVSYNC) begin    
      if (negedge_nHSYNC) begin  
        n64_480i <= ~FrameID;    
        FrameID  <= 1'b1;        
      end else begin             
        n64_480i <= FrameID;     
        FrameID  <= 1'b0;        
      end
    end
  end
end
reg [1:0] line_cnt;     
reg       vmode = 1'b0; 
always @(posedge VCLK) begin
  if (!nDSYNC) begin
    if(posedge_nVSYNC) begin 
      line_cnt <= 2'b00;     
      vmode    <= ~line_cnt[1]; 
    end else if(posedge_nHSYNC) 
      line_cnt <= line_cnt + 1'b1; 
  end
end
assign vinfo_o = {data_cnt, vmode, n64_480i};
endmodule