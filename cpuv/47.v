module blk_mem_axi_regs_fwd_v8_2
  #(parameter C_DATA_WIDTH = 8 
   )(
    input   ACLK,               
    input   ARESET,             
    input   S_VALID,            
    output  S_READY,            
    input   [C_DATA_WIDTH-1:0] S_PAYLOAD_DATA, 
    output  M_VALID,            
    input   M_READY,            
    output  reg [C_DATA_WIDTH-1:0] M_PAYLOAD_DATA 
    );
    reg  [C_DATA_WIDTH-1:0] STORAGE_DATA;
    wire S_READY_I;            
    reg  M_VALID_I;            
    reg  [1:0] ARESET_D;       
    assign S_READY = S_READY_I;
    assign M_VALID = M_VALID_I;
    always @(posedge ACLK) begin
        ARESET_D <= {ARESET_D[0], ARESET};
    end
    always @(posedge ACLK or posedge ARESET) begin
        if (ARESET == 1'b1) begin
            STORAGE_DATA <= 0; 
        end else begin
            if(S_VALID == 1'b1 && S_READY_I == 1'b1 ) begin
                STORAGE_DATA <= S_PAYLOAD_DATA; 
            end
        end
    end
    always @(posedge ACLK) begin
        M_PAYLOAD_DATA <= STORAGE_DATA;
    end
    always @(posedge ACLK or posedge ARESET_D) begin
        if (ARESET_D != 2'b00) begin
            M_VALID_I <= 1'b0; 
        end else begin
            if (S_VALID == 1'b1) begin
                M_VALID_I <= 1'b1;
            end else if (M_READY == 1'b1 ) begin
                M_VALID_I <= 1'b0;
            end
        end
    end
    assign S_READY_I = (M_READY || (!M_VALID_I)) && !(|(ARESET_D));
endmodule