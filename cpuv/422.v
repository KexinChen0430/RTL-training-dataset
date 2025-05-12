module riscv_core (
    input                   clk,         
    input                   rstn,        
    output [`REG_W-1:0]     imem_addr,   
    input  [`INSTR_W-1:0]   imem_rdata,  
    output [`REG_W-1:0]     dmem_addr,   
    output                  dmem_cs,     
    output                  dmem_rnw,    
    output [(`DATA_W/8)-1:0] dmem_wmask, 
    output [`DATA_W-1:0]    dmem_wdata,  
    input  [`DATA_W-1:0]    dmem_rdata,  
    output                  stalled      
);
localparam OPCODE_IMM       = 7'b0010011;
localparam OPCODE_LUI       = 7'b0110111;
localparam OPCODE_AUIPC     = 7'b0010111;
localparam OPCODE_OP        = 7'b0110011;
localparam OPCODE_JAL       = 7'b1101111;
localparam OPCODE_JALR      = 7'b1100111;
localparam OPCODE_BRANCH    = 7'b1100011;
localparam OPCODE_LOAD      = 7'b0000011;
localparam OPCODE_STORE     = 7'b0100011;
localparam OPCODE_MISC_MEM  = 7'b0001111;
localparam OPCODE_SYSTEM    = 7'b1110011;
reg [`REG_W-1:0] pc_reg;          
reg [`REG_W-1:0] reg_file [0:31]; 
reg [`REG_W-1:0] pc_nxt;          
reg stall_back;                    
reg take_branch;                   
reg [`REG_W-1:0] target;          
initial begin
    stall_back = 0;
    take_branch = 0;
end
assign imem_addr = pc_reg;
always @ (*) begin
    if (stall_back) begin
        pc_nxt = pc_reg; 
    end
    else if (take_branch) begin
        pc_nxt = target; 
    end
    else begin
        pc_nxt = pc_reg + 4; 
    end
end
always @ (posedge clk, negedge rstn) begin
    if (rstn == 0) begin
        pc_reg <= 'h0; 
    end
    else begin
        pc_reg <= pc_nxt; 
    end
end
wire [`REG_W-1:0] instr;
assign instr = imem_rdata; 
wire [31:0] rsj; 
wire [31:0] rsk; 
assign rsj = reg_file[rsj_sel]; 
assign rsk = reg_file[rsk_sel]; 
wire [4:0]  rsj_sel; 
wire [4:0]  rsk_sel; 
wire [4:0]  rsd_sel; 
assign rsd_sel = instr[11:7];  
assign rsj_sel = instr[19:15]; 
assign rsk_sel = instr[24:20]; 
endmodule