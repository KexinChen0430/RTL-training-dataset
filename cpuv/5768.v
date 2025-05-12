module uut_8_top
(
    output wire [31:0] res_o, 
    output wire [31:0] exp_o, 
    output wire [31:0] obs_o, 
    output wire        val_o, 
    input  wire [7:0]  data_i, 
    input  wire        sof_i, 
    input  wire        eof_i, 
    input  wire        pclk_i 
);
    localparam         LO                = 1'b0; 
    localparam         HI                = 1'b1; 
    localparam [31:0]  ZEROS             = {32{LO}}; 
    localparam [31:0]  ONES              = {32{HI}}; 
    localparam         FIRST             = 7; 
    localparam         LAST              = 9; 
    reg  [7:0]   data_z1;
    reg          sof_z1;
    reg  [7:0]   data_z2;
    reg          sof_z2;
    reg  [7:0]   data_z3;
    reg          sof_z3;
    reg  [7:0]   data_z4;
    reg          sof_z4;
    reg          val_z5;
    reg  [31:0]  exp_z5;
    reg  [31:0]  fcs_z5;
    reg          val_z6;
    reg  [31:0]  exp_z6;
    reg  [31:0]  fcs_z6;
    reg  [31:0]  exp[FIRST:LAST];
    reg  [31:0]  crc[FIRST:LAST];
    reg          val[FIRST:LAST];
    always @ (posedge pclk_i) begin
        data_z1[7:0] <= data_i[7:0]; 
        sof_z1       <= sof_i; 
        data_z2[7:0] <= data_z1[7:0]; 
        sof_z2       <= sof_z1; 
        data_z3[7:0] <= data_z2[7:0]; 
        sof_z3       <= sof_z2; 
        data_z4[7:0] <= data_z3[7:0]; 
        sof_z4       <= sof_z3; 
        val_z5       <= eof_i; 
        if (eof_i == HI) begin
            exp_z5[31:0] <= {data_z3[7:0], data_z2[7:0], data_z1[7:0], data_i[7:0]};
        end
        if (sof_z4 == HI) begin
            fcs_z5[31:0] <= fcs32_8(data_z4[7:0], ONES[31:0]);
        end else begin
            fcs_z5[31:0] <= fcs32_8(data_z4[7:0], fcs_z5[31:0]);
        end
        val_z6 <= val_z5;
        exp_z6[31:0] <= exp_z5[31:0];
        fcs_z6[31:0] <= fcs32_brev(fcs_z5[31:0]);
    end
    generate
        genvar i;
        for (i = FIRST ; i <= LAST ; i = i + 1) begin : ppln_delay
            always @ (posedge pclk_i) begin
                if (i == FIRST) begin
                    exp[i][31:0] <= exp_z6[31:0]; 
                    crc[i][31:0] <= fcs_z6[31:0]; 
                    val[i]       <= val_z6; 
                end else begin
                    exp[i][31:0] <= exp[i - 1][31:0]; 
                    crc[i][31:0] <= crc[i - 1][31:0]; 
                    val[i]       <= val[i - 1]; 
                end
            end
        end
    endgenerate
    always @ (*) begin
        res_o[31:0] = fcs_z5[31:0]; 
        exp_o[31:0] = exp[LAST][31:0]; 
        obs_o[31:0] = crc[LAST][31:0]; 
        val_o       = val[LAST]; 
    end
endmodule