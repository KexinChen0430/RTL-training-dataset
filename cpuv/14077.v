module n64_vinfo_ext(
  VCLK,
  nVDSYNC,
  nRST,
  Sync_pre,
  Sync_cur,
  vinfo_o
);
`include "vh/n64adv_vparams.vh" 
input VCLK;          
input nVDSYNC;       
input nRST;          
input  [3:0] Sync_pre;  
input  [3:0] Sync_cur;  
output [1:0] vinfo_o;   
wire posedge_nVSYNC = !Sync_pre[3] &  Sync_cur[3]; 
wire negedge_nVSYNC =  Sync_pre[3] & !Sync_cur[3]; 
wire posedge_nHSYNC = !Sync_pre[1] &  Sync_cur[1]; 
wire negedge_nHSYNC =  Sync_pre[1] & !Sync_cur[1]; 
reg FrameID  = 1'b0; 
reg n64_480i = 1'b1; 
always @(posedge VCLK or negedge nRST) 
  if (!nRST) begin 
    FrameID  <= 1'b0; 
    n64_480i <= 1'b1; 
  end else if (!nVDSYNC) begin 
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
reg [1:0] line_cnt = 2'b00; 
reg        palmode = 1'b0;  
always @(posedge VCLK or negedge nRST) 
  if (!nRST) begin 
    line_cnt <= 2'b00; 
    palmode  <= 1'b0;  
  end else if (!nVDSYNC) begin 
    if(posedge_nVSYNC) begin 
      line_cnt <= 2'b00;     
      palmode  <= ~line_cnt[1]; 
    end else if(posedge_nHSYNC) 
      line_cnt <= line_cnt + 1'b1; 
  end
assign vinfo_o = {palmode,n64_480i}; 
endmodule 