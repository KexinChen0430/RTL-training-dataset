module altpciexpav_clksync ( cg_common_clock_mode_i,
                       Clk1_i,
                       Clk2_i,
                       Clk1Rstn_i,
                       Clk2Rstn_i,
                       Sig1_i,
                       Sig2_o,
                       SyncPending_o,
                       Ack_o);
input cg_common_clock_mode_i; 
input Clk1_i;                 
input Clk2_i;                 
input Clk1Rstn_i;             
input Clk2Rstn_i;             
input Sig1_i;                 
output Sig2_o;                
output Ack_o;                 
output SyncPending_o;         
wire input_rise;              
reg input_sig_reg;            
(* altera_attribute = {"-name SYNCHRONIZER_IDENTIFICATION FORCED_IF_ASYNCHRONOUS"} *) reg output1_reg;
(* altera_attribute = {"-name SYNCHRONIZER_IDENTIFICATION FORCED_IF_ASYNCHRONOUS"} *) reg output2_reg;
reg output3_reg;              
reg sig2_o_reg;               
reg req_reg;                  
reg ack_reg;                  
(* altera_attribute = {"-name SYNCHRONIZER_IDENTIFICATION FORCED_IF_ASYNCHRONOUS"} *) reg ack1_reg;
(* altera_attribute = {"-name SYNCHRONIZER_IDENTIFICATION FORCED_IF_ASYNCHRONOUS"} *) reg ack2_reg;
reg ack3_reg;                 
reg pending_reg;              
always @(posedge Clk1_i or negedge Clk1Rstn_i)
  begin
    if(~Clk1Rstn_i)
      input_sig_reg <= 1'b0;  
    else
      input_sig_reg <= Sig1_i; 
  end
assign input_rise = ~input_sig_reg & Sig1_i;
always @(posedge Clk1_i or negedge Clk1Rstn_i)
  begin
    if(~Clk1Rstn_i)
      begin
      req_reg <= 1'b0;        
      pending_reg <= 1'b0;    
      end
    else
      begin
      if(input_rise)
	req_reg <= ~req_reg;   
      if (input_rise)
	pending_reg <= 1'b1;   
      else if (ack3_reg^ack2_reg)
	pending_reg <= 1'b0;   
      end
  end
always @(posedge Clk2_i or negedge Clk2Rstn_i)
  begin
    if(~Clk2Rstn_i)
      begin
      output1_reg <= 1'b0;    
      output2_reg <= 1'b0;    
      output3_reg <= 1'b0;    
      sig2_o_reg <= 1'b0;     
      ack_reg <= 1'b0;        
      end
    else
      begin
      output1_reg <= req_reg; 
      output2_reg <= output1_reg; 
      output3_reg <= output2_reg; 
      if (output3_reg^output2_reg)
	sig2_o_reg <= 1'b1;
      else
	sig2_o_reg <= 1'b0;
      if (output3_reg^output2_reg)
	ack_reg <= ~ack_reg;
      end
  end
always @(posedge Clk1_i or negedge Clk1Rstn_i)
  begin
    if(~Clk1Rstn_i)
      begin
      ack1_reg <= 1'b0;       
      ack2_reg <= 1'b0;       
      ack3_reg <= 1'b0;       
      end
    else
      begin
      ack1_reg <= ack_reg;    
      ack2_reg <= ack1_reg;   
      ack3_reg <= ack2_reg;   
      end
  end
assign Sig2_o = (cg_common_clock_mode_i == 0) ? sig2_o_reg : input_sig_reg;
assign Ack_o = ack2_reg;
assign SyncPending_o = (cg_common_clock_mode_i == 0) ? pending_reg : 1'b0;
endmodule 