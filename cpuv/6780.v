module DATA_MEMORY_STAGE #( 
    parameter   DATA_WIDTH              = 32        , 
    parameter   REG_ADD_WIDTH           = 5         , 
    parameter   D_CACHE_LW_WIDTH        = 3         , 
    parameter   HIGH                    = 1'b1      , 
    parameter   LOW                     = 1'b0      
) (
    input                                   CLK                         , 
    input                                   STALL_DATA_MEMORY_STAGE     , 
    input   [REG_ADD_WIDTH - 1      : 0]    RD_ADDRESS_IN               , 
    input   [DATA_WIDTH - 1         : 0]    ALU_OUT_IN                  , 
    input   [D_CACHE_LW_WIDTH - 1   : 0]    DATA_CACHE_LOAD_IN          , 
    input                                   WRITE_BACK_MUX_SELECT_IN    , 
    input                                   RD_WRITE_ENABLE_IN          , 
    output  [REG_ADD_WIDTH - 1      : 0]    RD_ADDRESS_OUT              , 
    output  [DATA_WIDTH - 1         : 0]    ALU_OUT_OUT                 , 
    output  [D_CACHE_LW_WIDTH - 1   : 0]    DATA_CACHE_LOAD_OUT         , 
    output                                  WRITE_BACK_MUX_SELECT_OUT   , 
    output                                  RD_WRITE_ENABLE_OUT             
);
reg     [REG_ADD_WIDTH - 1      : 0]    rd_address_reg                  ; 
reg     [DATA_WIDTH - 1         : 0]    alu_out_reg                     ; 
reg     [D_CACHE_LW_WIDTH - 1   : 0]    data_cache_load_reg             ; 
reg                                     write_back_mux_select_reg       ; 
reg                                     rd_write_enable_reg             ; 
always@(posedge CLK) 
begin
    if(STALL_DATA_MEMORY_STAGE == LOW) 
    begin
        rd_address_reg              <= RD_ADDRESS_IN                    ; 
        alu_out_reg                 <= ALU_OUT_IN                       ; 
        data_cache_load_reg         <= DATA_CACHE_LOAD_IN               ; 
        write_back_mux_select_reg   <= WRITE_BACK_MUX_SELECT_IN         ; 
        rd_write_enable_reg         <= RD_WRITE_ENABLE_IN               ; 
    end
end
assign RD_ADDRESS_OUT               = rd_address_reg                    ; 
assign ALU_OUT_OUT                  = alu_out_reg                       ; 
assign DATA_CACHE_LOAD_OUT          = data_cache_load_reg               ; 
assign WRITE_BACK_MUX_SELECT_OUT    = write_back_mux_select_reg         ; 
assign RD_WRITE_ENABLE_OUT          = rd_write_enable_reg               ; 
endmodule 