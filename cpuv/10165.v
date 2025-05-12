module md     (
    clk                 , 
    rst_n               , 
    ipre_bank_o         , 
    ec_bank_o           , 
    db_bank_o           , 
    cef_wen_i           , 
    cef_widx_i          , 
    cef_data_i          , 
    ec_mb_type_o        , 
    ec_mb_partition_o   , 
    ec_i_mode_o         , 
    ec_p_mode_o         , 
    db_non_zero_count_o   
);
input                           clk             ; 
input                           rst_n           ; 
output [1:0]                    ipre_bank_o     ; 
output [1:0]                    ec_bank_o       ; 
output [1:0]                    db_bank_o       ; 
input                           cef_wen_i       ; 
input [4:0]                     cef_widx_i      ; 
input [`COEFF_WIDTH*32-1:0]     cef_data_i      ; 
output                          ec_mb_type_o    ; 
output [20:0]                   ec_mb_partition_o; 
output [((2^`CU_DEPTH)^2)*6-1:0]ec_i_mode_o     ; 
output [169:0]                  ec_p_mode_o     ; 
output                          db_non_zero_count_o; 
endmodule