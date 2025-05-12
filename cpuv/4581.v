module uut_1_bitp
(
    output wire [31:0] res_o,    
    output wire [31:0] exp_o,    
    output wire [31:0] obs_o,    
    output wire        val_o,    
    input  wire [31:0] data_i,   
    input  wire        sof_i,    
    input  wire        eof_i,    
    input  wire        bstb_i,   
    input  wire        bclk_i    
);
    localparam         LO                = 1'b0; 
    localparam         HI                = 1'b1; 
    localparam [31:0]  ZEROS             = {32{LO}}; 
    localparam [31:0]  ONES              = {32{HI}}; 
    localparam         FIRST             = 4; 
    localparam         LAST              = 34; 
    reg          dat_z1; 
    reg          bgn_z1; 
    reg          end_z1; 
    reg  [31:0]  exp_z2; 
    reg  [31:0]  fcs_z2; 
    reg          end_z2; 
    reg  [31:0]  exp_z3; 
    reg  [31:0]  fcs_z3; 
    reg          val_z3; 
    reg  [31:0]  exp[FIRST:LAST]; 
    reg  [31:0]  crc[FIRST:LAST]; 
    reg          val[FIRST:LAST]; 
    integer      bit_cnt; 
    always @ (posedge bclk_i) begin
        if (bstb_i == HI) begin
            bit_cnt <= 0; 
        end else begin
            bit_cnt <= bit_cnt + 1; 
        end
        bgn_z1 <= LO; 
        end_z1 <= LO; 
        dat_z1 <= data_i[bit_cnt + 24]; 
        if (bit_cnt == 7) begin
            end_z1 <= eof_i; 
        end else if (bit_cnt == 0) begin
            bgn_z1 <= sof_i; 
        end
        end_z2 <= end_z1; 
        if (end_z1 == HI) begin
            exp_z2[31:0] <= data_i[31:0]; 
        end
        if (bgn_z1 == HI) begin
            fcs_z2[31:0] <= fcs32_1(dat_z1, ONES[31:0]); 
        end else begin
            fcs_z2[31:0] <= fcs32_1(dat_z1, fcs_z2[31:0]); 
        end
        val_z3       <= end_z2; 
        exp_z3[31:0] <= exp_z2[31:0]; 
        if (end_z2 == HI) begin
            fcs_z3[31:0] <= fcs32_brev(fcs_z2[31:0]); 
        end
    end
    generate
        genvar i;
        for (i = FIRST ; i <= LAST ; i = i + 1) begin : ppln_delay
            always @ (posedge bclk_i) begin
                if (i == FIRST) begin
                    exp[i][31:0] <= exp_z3[31:0]; 
                    crc[i][31:0] <= fcs_z3[31:0]; 
                    val[i]       <= val_z3;       
                end else begin
                    exp[i][31:0] <= exp[i - 1][31:0]; 
                    crc[i][31:0] <= crc[i - 1][31:0]; 
                    val[i]       <= val[i - 1];       
                end
            end
        end
    endgenerate
    always @ (*) begin
        res_o[31:0] = fcs_z2[31:0]; 
        exp_o[31:0] = exp[LAST][31:0]; 
        obs_o[31:0] = crc[LAST][31:0]; 
        val_o       = val[LAST]; 
    end
endmodule