module decode(
    input        clk_i,
    input        reset_i,
    input  [31:0]  inst_i,
    input        inst_en_i,
    input  [63:0]  rs1val_i,
    input  [63:0]  rs2val_i,
    input  [4:0]   ex_rd_i,
    input  [4:0]   mem_rd_i,
    input  [63:0]  ex_q_i,
    input  [63:0]  mem_q_i,
    output [63:0]  inpa_o,
    output [63:0]  inpb_o,
    output         invB_o,
    output         cflag_o,
    output         lsh_en_o,
    output         rsh_en_o,
    output         ltu_en_o,
    output         lts_en_o,
    output         sum_en_o,
    output         and_en_o,
    output         xor_en_o,
    output [4:0]   rd_o,
    output [4:0]   rs1_o,
    output [4:0]   rs2_o,
    output         we_o,
    output         nomem_o,
    output         mem_o,
    output [63:0]  dat_o,
    output [2:0]   xrs_rwe_o,
    output         illegal_o
);
reg  [31:0]  inst_r;
reg          illegal_o;
reg  [63:0]  inpa_o;
reg  [63:0]  inpb_o;
reg  [63:0]  dat_o;
reg          invB_o;
reg          cflag_o;
reg          lsh_en_o;
reg          rsh_en_o;
reg          ltu_en_o;
reg          lts_en_o;
reg          sum_en_o;
reg          and_en_o;
reg          xor_en_o;
reg          we_o;
reg          nomem_o;
reg          mem_o;
reg  [2:0]   xrs_rwe_o;
wire [4:0]   rs1_r = inst_r[19:15];
wire [4:0]   rs2_r = inst_r[24:20];
assign rs2_o = inst_i[24:20];
assign rs1_o = inst_i[19:15];
assign rd_o = inst_r[11:7];
wire hit1_ex = (ex_rd_i === rs1_r) && |rs1_r;
wire hit1_mem = (mem_rd_i === rs1_r) && |rs1_r;
wire hit2_ex = (ex_rd_i === rs2_r) && |rs2_r;
wire hit2_mem = (mem_rd_i === rs2_r) && |rs2_r;
wire [63:0] rs1val =
    (hit1_ex ? ex_q_i
             : (hit1_mem ? mem_q_i
                         : rs1val_i));
wire [63:0] rs2val =
    (hit2_ex ? ex_q_i
             : (hit2_mem ? mem_q_i
                         : rs2val_i));
wire [63:0] imm12 = {{52{inst_r[31]}}, inst_r[31:20]};
wire [63:0] imm12s = {{52{inst_r[31]}}, inst_r[31:25], inst_r[11:7]};
always @(*) begin
    illegal_o <= 1;
    inpa_o <= 0;
    inpb_o <= 0;
    dat_o <= 0;
    invB_o <= 0;
    cflag_o <= 0;
    {lsh_en_o, rsh_en_o, ltu_en_o, lts_en_o, sum_en_o, and_en_o, xor_en_o} <= 0;
    we_o <= 0;
    nomem_o <= 1;
    mem_o <= 0;
    xrs_rwe_o <= `XRS_RWE_S64; 
    if (inst_r[1:0] == 2'b11) begin
        if((inst_r[6:5] == 2'b01) &&
           (inst_r[4:2] == 3'b000) &&
           (inst_r[14] == 0)) begin
            illegal_o <= 0;
            inpa_o <= rs1val;
            inpb_o <= imm12s;
            sum_en_o <= 1;
            nomem_o <= 0;
            mem_o <= 1;
            we_o <= 1;
            dat_o <= rs2val;
            case (inst_r[13:12])
            2'b00: xrs_rwe_o <= `XRS_RWE_S8;
            2'b01: xrs_rwe_o <= `XRS_RWE_S16;
            2'b10: xrs_rwe_o <= `XRS_RWE_S32;
            2'b11: xrs_rwe_o <= `XRS_RWE_S64;
            endcase
        end
        if((inst_r[6:5] == 2'b00) &&
           (inst_r[4:2] == 3'b100)) begin
            illegal_o <= 0;
            inpa_o <= rs1val;
            inpb_o <= imm12;
            case (inst_r[14:12])
            3'b000: sum_en_o <= 1;
            3'b001: lsh_en_o <= 1;
            3'b010: lts_en_o <= 1;
            3'b011: ltu_en_o <= 1;
            3'b100: xor_en_o <= 1;
            3'b101: {cflag_o, rsh_en_o} <= {inst_r[30], 1'b1};
            3'b110: {and_en_o, xor_en_o} <= 2'b11;
            3'b111: and_en_o <= 1;
            endcase
        end
    end
end
always @(posedge clk_i) begin
    inst_r <= inst_r;
    if (reset_i) begin
        inst_r <= `INST_NOP; 
    end
    else begin
        if(inst_en_i) begin
            inst_r <= inst_i; 
        end
    end
end
endmodule