module altor32_fetch
(
    input               clk_i , 
    input               rst_i , 
    output              fetch_o , 
    output reg [31:0]   pc_o , 
    input [31:0]        data_i , 
    input               data_valid_i, 
    input               branch_i , 
    input [31:0]        branch_pc_i , 
    input               stall_i , 
    output [31:0]       opcode_o , 
    output [31:0]       opcode_pc_o , 
    output              opcode_valid_o , 
    output [4:0]        ra_o , 
    output [4:0]        rb_o , 
    output [4:0]        rd_o  
);
parameter   BOOT_VECTOR             = 32'h00000000; 
parameter   CACHE_LINE_SIZE_WIDTH   = 5; 
parameter   PIPELINED_FETCH         = "DISABLED"; 
reg         rd_q; 
reg [31:0]  pc_q; 
reg [31:0]  pc_last_q; 
wire [31:0] next_pc_w = pc_q + 32'd4; 
always @ (posedge clk_i or posedge rst_i)
begin
   if (rst_i) 
   begin
        pc_q        <= BOOT_VECTOR + `VECTOR_RESET; 
        pc_last_q   <= BOOT_VECTOR + `VECTOR_RESET; 
        rd_q        <= 1'b1; 
   end
   else if (~stall_i) 
   begin
        if (branch_i) 
        begin
            rd_q        <= 1'b0; 
            pc_last_q   <= pc_o; 
            pc_q        <= branch_pc_i + 4; 
        end
        else if (data_valid_i) 
        begin
            if (next_pc_w[CACHE_LINE_SIZE_WIDTH-1:0] == {CACHE_LINE_SIZE_WIDTH{1'b0}})
                rd_q    <= 1'b1; 
            else
                rd_q    <= 1'b0; 
            pc_last_q   <= pc_o; 
            pc_q        <= next_pc_w; 
        end
        else 
        begin
            rd_q        <= 1'b0; 
            pc_last_q   <= pc_o; 
        end
   end
end
always @ *
begin
    if (stall_i) 
        pc_o    = pc_last_q; 
    else if (branch_i) 
        pc_o    = branch_pc_i; 
    else if (~data_valid_i) 
        pc_o    = pc_last_q; 
    else 
        pc_o    = pc_q; 
end
assign fetch_o  = branch_i ? 1'b1 : rd_q;
generate
if (PIPELINED_FETCH == "ENABLED") 
begin: FETCH_FLOPS
    reg [31:0] opcode_q; 
    reg [31:0] opcode_pc_q; 
    reg        opcode_valid_q; 
    reg        branch_q; 
    always @ (posedge clk_i or posedge rst_i)
    begin
       if (rst_i) 
       begin
            opcode_q        <= 32'b0; 
            opcode_pc_q     <= 32'b0; 
            opcode_valid_q  <= 1'b0; 
            branch_q        <= 1'b0; 
       end
       else 
       begin
            branch_q        <= branch_i; 
            if (~stall_i) 
            begin
                opcode_pc_q     <= pc_last_q; 
                opcode_q        <= data_i; 
                opcode_valid_q  <= (data_valid_i & !branch_i); 
            end
       end
    end
    assign opcode_valid_o  = opcode_valid_q & ~branch_i & ~branch_q; 
    assign opcode_o        = opcode_q; 
    assign opcode_pc_o     = opcode_pc_q; 
end
else
begin : NO_FETCH_FLOPS
    assign opcode_valid_o  = (data_valid_i & !branch_i); 
    assign opcode_o        = data_i; 
    assign opcode_pc_o     = pc_last_q; 
end
endgenerate
`ifdef SIMULATION
    wire [7:0] fetch_inst_w = {2'b00, opcode_o[31:26]}; 
    wire       nop_inst_w   = (fetch_inst_w == `INST_OR32_NOP); 
    assign     ra_o         = nop_inst_w ? 5'd3 : opcode_o[20:16]; 
`else
    assign     ra_o         = opcode_o[20:16]; 
`endif
assign rb_o            = opcode_o[15:11]; 
assign rd_o            = opcode_o[25:21]; 
endmodule 