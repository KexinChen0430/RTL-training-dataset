module qm_dcache(
    input wire reset, 
    input wire clk, 
    output reg stall, 
    input wire [31:0] address, 
    output reg [31:0] read_data, 
    input wire [31:0] write_data, 
    input wire write_enable, 
    input wire enable, 
    output wire mem_cmd_clk, 
    output reg mem_cmd_en, 
    output reg [2:0] mem_cmd_instr, 
    output reg [5:0] mem_cmd_bl, 
    output reg [29:0] mem_cmd_addr, 
    input wire mem_cmd_full, 
    input wire mem_cmd_empty, 
    output wire mem_rd_clk, 
    output reg mem_rd_en, 
    input wire [6:0] mem_rd_count, 
    input wire mem_rd_full, 
    input wire [31:0] mem_rd_data, 
    input wire mem_rd_empty, 
    output wire mem_wr_clk, 
    output wire mem_wr_en, 
    output wire mem_wr_mask, 
    output wire [31:0] mem_wr_data, 
    input wire mem_wr_empty, 
    input wire mem_wr_full, 
    input wire mem_wr_underrun, 
    input wire [6:0] mem_wr_count, 
    input wire mem_wr_data 
);
reg [145:0] lines [4095:0]; 
reg valid_bit; 
wire [11:0] index; 
wire index_valid; 
wire [15:0] index_tag; 
wire [15:0] address_tag; 
wire [1:0] address_word; 
assign index = address[15:4];
assign index_synced = lines[index][145]; 
assign index_valid = lines[index][144]; 
assign index_tag = lines[index][143:128]; 
assign address_tag = address[31:16]; 
assign address_word = address[3:2]; 
assign mem_rd_clk = ~clk; 
assign mem_wr_clk = ~clk; 
assign mem_cmd_clk = ~clk; 
assign mem_wr_mask = 32'b0; 
generate
    genvar i;
    for (i = 0; i < 4096; i = i + 1) begin: ruchanie 
        always @(posedge clk) begin
            if (reset) begin
                lines[i] <= {146'b0}; 
            end
        end
    end
endgenerate
always @(posedge clk) begin
    if (reset) begin
        valid_bit <= 1; 
        memory_read_state <= 0; 
        memory_write_state <= 0; 
        mem_cmd_en <= 0; 
        mem_cmd_bl <= 0; 
        mem_cmd_instr <= 0; 
        mem_cmd_addr <= 0; 
        mem_rd_en <= 0; 
    end
end
always @(*) begin
    if (enable) begin
        if (32'h80000000 <= address && address < 32'h90000000) begin
            if (index_valid == valid_bit && index_tag == address_tag) begin
                if (address_word == 2'b00)
                    read_data = lines[index][31:0];
                else if (address_word == 2'b01)
                    read_data = lines[index][63:32];
                else if (address_word == 2'b10)
                    read_data = lines[index][95:64];
                else
                    read_data = lines[index][127:96];
                stall = 0; 
            end else begin
                stall = 1; 
            end
        end else begin
            read_data = 32'h00000000; 
            stall = 0; 
        end
    end else begin
        stall = 0; 
    end
end
reg [2:0] memory_read_state;
reg [2:0] memory_write_state;
always @(posedge clk) begin
    if ((stall && !reset && enable && index_synced == 1) || 
        (memory_read_state != 0 && !reset && enable)) begin 
        case (memory_read_state)
            0: begin 
                mem_cmd_instr <= 1; 
                mem_cmd_bl <= 3; 
                mem_cmd_addr <= {1'b0, address[28:0]}; 
                mem_cmd_en <= 1; 
                mem_rd_en <= 1; 
                memory_read_state <= 1; 
            end
            1: begin 
                mem_cmd_en <= 0; 
                if (!mem_rd_empty) begin 
                    lines[index][31:0] <= mem_rd_data; 
                    memory_read_state <= 2; 
                end
            end
            2: begin 
                if (!mem_rd_empty) begin 
                    lines[index][63:32] <= mem_rd_data; 
                    memory_read_state <= 3; 
                end
            end
            3: begin 
                if (!mem_rd_empty) begin 
                    lines[index][95:64] <= mem_rd_data; 
                    memory_read_state <= 4; 
                end
            end
            4: begin 
                if (!mem_rd_empty) begin 
                    lines[index][127:96] <= mem_rd_data; 
                    memory_read_state <= 0; 
                    mem_rd_en <= 0; 
                    lines[index][143:128] <= address_tag; 
                    lines[index][144] <= valid_bit; 
                end
            end
        endcase
    end
end
always @(posedge clk) begin
    if ((stall && !reset && enable && index_synced == 0) || 
        (memory_write_state != 0 && !reset && enable)) begin 
        case (memory_write_state)
            0: begin 
                if (!mem_wr_full) begin 
                    mem_wr_en <= 1; 
                    mem_wr_data <= lines[index][31:0]; 
                    memory_write_state <= 1; 
                end
            end
            1: begin 
                if (!mem_wr_full) begin 
                    mem_wr_data <= lines[index][63:32]; 
                    memory_write_state <= 2; 
                end
            end
            2: begin 
                if (!mem_wr_full) begin 
                    mem_wr_data <= lines[index][95:64]; 
                    memory_write_state <= 3; 
                end
            end
            3: begin 
                if (!mem_wr_full) begin 
                    mem_wr_data <= lines[index][127:96]; 
                    mem_cmd_en <= 1; 
                    mem_cmd_instr <= 0; 
                    mem_cmd_bl <= 3; 
                    mem_cmd_addr <= {1'b0, address[28:0]}; 
                    memory_write_state <= 4; 
                end
            end
            4: begin 
                mem_wr_en <= 0; 
                mem_cmd_en <= 0; 
                memory_write_state <= 0; 
            end
        endcase
    end
end
endmodule 