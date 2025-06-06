
module register_sync  #(parameter 
       reg_width     = 16,
       reg_preset    = {reg_width{1'b0}},
       resync_stages = 1<<1)
  (clk,clk_en,nrst,reg_i,reg_o);

  input  clk;
  input  clk_en;
  input  nrst;
  input  [reg_width-1:0] reg_i;
  output [reg_width-1:0] reg_o;
  reg  [reg_width-1:0]  reg_synced_3 = reg_preset;
  reg  [reg_width-1:0]  reg_synced_2 = reg_preset;
  reg  [reg_width-1:0]  reg_synced_1 = reg_preset;
  reg  [reg_width-1:0]  reg_synced_0 = reg_preset;

  
  always @(posedge clk or negedge nrst)
      if (!nrst) 
        begin
          reg_synced_2 <= reg_preset;
          reg_synced_1 <= reg_preset;
          reg_synced_0 <= reg_preset;
        end
      else if (clk_en) 
        begin
          reg_synced_2 <= reg_synced_1;
          reg_synced_1 <= reg_synced_0;
          reg_synced_0 <= reg_i;
        end
        
  genvar int_idx;
  
  generate
      for (int_idx = 0; int_idx < reg_width; int_idx = int_idx+1)
          begin : gen_rtl
            
            always @(posedge clk or negedge nrst)
                if (!nrst) 
                  begin
                    reg_synced_3[int_idx] <= reg_preset[int_idx];
                  end
                else if (clk_en) 
                  begin
                    if (reg_synced_2[int_idx] == reg_synced_1[int_idx]) reg_synced_3[int_idx] <= reg_synced_2[int_idx];
                      
                  end
                  
          end
  endgenerate

  
  generate
      if (resync_stages == 4) assign reg_o = reg_synced_3;
      else if (resync_stages == 3) assign reg_o = reg_synced_2;
      else if (resync_stages == 1) assign reg_o = reg_synced_0;
      else assign reg_o = reg_synced_1;
  endgenerate

endmodule

