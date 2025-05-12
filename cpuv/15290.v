module aes
  #(
    parameter ovl_enable = 0  
  )
  (
    input          reset_i,  
    input          clk_i,    
    input          mode_i,   
    input  [0:127] key_i,    
    input  [0:127] data_i,   
    input          valid_i,  
    output [0:127] data_o,   
    output         valid_o   
  );
`include aes_pkg.v;
endmodule