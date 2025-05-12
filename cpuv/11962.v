module bsg_dmc_phy_tx_bit_slice 
  (input        clk_2x_i        
  ,input        wrdata_en_90_i  
  ,input  [1:0] wrdata_90_i     
  ,output logic dq_o            
  ,output logic dq_oe_n_o);     
  wire clk_2x_n = ~clk_2x_i;    
  logic odd;                    
  always_ff @(posedge clk_2x_n) begin 
    if(wrdata_en_90_i) begin            
      odd <= ~odd;                      
      if(odd) begin                     
        dq_o <= wrdata_90_i[1];         
      end
      else begin                        
        dq_o <= wrdata_90_i[0];         
      end
      dq_oe_n_o <= 1'b0;                
    end
    else begin                          
      odd <= 1'b0;                      
      dq_oe_n_o <= 1'b1;                
    end
  end
endmodule