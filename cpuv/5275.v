module dblfetch(
    i_clk, i_rst, i_new_pc, i_clear_cache,
    i_stall_n, i_pc, o_i, o_pc, o_v,
    o_wb_cyc, o_wb_stb, o_wb_we, o_wb_addr, o_wb_data,
    i_wb_ack, i_wb_stall, i_wb_err, i_wb_data,
    o_illegal
);
parameter ADDRESS_WIDTH = 32;
localparam AW = ADDRESS_WIDTH;
input wire i_clk, i_rst, i_new_pc, i_clear_cache, i_stall_n;
input wire [(AW-1):0] i_pc;
output reg [31:0] o_i; 
output reg [(AW-1):0] o_pc; 
output wire o_v; 
output reg o_wb_cyc, o_wb_stb; 
output wire o_wb_we; 
output reg [(AW-1):0] o_wb_addr; 
output wire [31:0] o_wb_data; 
input wire i_wb_ack, i_wb_stall, i_wb_err; 
input wire [31:0] i_wb_data; 
output reg o_illegal;
assign o_wb_we = 1'b0;
assign o_wb_data = 32'h0000;
reg last_ack, last_stb, invalid_bus_cycle;
reg [31:0] cache[0:1]; 
reg cache_read_addr, cache_write_addr; 
reg [1:0] cache_valid; 
initial o_wb_cyc = 1'b0;
initial o_wb_stb = 1'b0;
always @(posedge i_clk) begin
    if (i_rst || i_wb_err) begin
        o_wb_cyc <= 1'b0;
        o_wb_stb <= 1'b0;
    end else if (o_wb_cyc) begin
        if (o_wb_stb && !i_wb_stall) begin
            o_wb_stb <= !last_stb;
        end
        if (i_new_pc || invalid_bus_cycle) begin
            o_wb_stb <= 1'b0;
        end
        if (i_wb_ack && (last_ack || (o_wb_stb && i_wb_stall && last_stb && (i_new_pc || invalid_bus_cycle)))) begin
            o_wb_cyc <= 1'b0;
            o_wb_stb <= 1'b0;
        end
        if (!last_stb && i_wb_stall && (i_new_pc || invalid_bus_cycle)) begin
            o_wb_cyc <= 1'b0;
            o_wb_stb <= 1'b0;
        end
    end else if (invalid_bus_cycle || (o_v && i_stall_n && cache_read_addr)) begin
        o_wb_cyc <= 1'b1;
        o_wb_stb <= 1'b1;
    end
end
initial last_stb = 1'b0;
always @(posedge i_clk) begin
    if (o_wb_cyc && o_wb_stb && !i_wb_stall) begin
        last_stb <= 1'b1;
    end else if (!o_wb_cyc) begin
        last_stb <= 1'b0;
    end
end
initial last_ack = 1'b0;
always @(posedge i_clk) begin
    if (o_wb_cyc && i_wb_ack) begin
        last_ack <= 1'b1;
    end else if (o_wb_cyc && o_wb_stb && i_wb_stall && (i_new_pc || invalid_bus_cycle)) begin
        last_ack <= 1'b1;
    end else if (o_wb_cyc && o_wb_stb && !i_wb_stall && !last_stb && (i_new_pc || invalid_bus_cycle)) begin
        last_ack <= 1'b1;
    end else if (!o_wb_cyc) begin
        last_ack <= 1'b0;
    end
end
initial invalid_bus_cycle = 1'b0;
always @(posedge i_clk) begin
    if (i_rst) begin
        invalid_bus_cycle <= 1'b0;
    end else if (i_new_pc || i_clear_cache) begin
        invalid_bus_cycle <= 1'b1;
    end else if (!o_wb_cyc) begin
        invalid_bus_cycle <= 1'b0;
    end
end
initial o_wb_addr = {(AW){1'b1}};
always @(posedge i_clk) begin
    if (i_new_pc) begin
        o_wb_addr <= i_pc;
    end else if (o_wb_stb && !i_wb_stall && !invalid_bus_cycle) begin
        o_wb_addr <= o_wb_addr + 1'b1;
    end
end
initial cache_write_addr = 1'b0;
always @(posedge i_clk) begin
    if (!o_wb_cyc) begin
        cache_write_addr <= 1'b0;
    end else if (o_wb_cyc && i_wb_ack) begin
        cache_write_addr <= cache_write_addr + 1'b1;
    end
end
always @(posedge i_clk) begin
    if (o_wb_cyc && i_wb_ack) begin
        cache[cache_write_addr] <= i_wb_data;
    end
end
initial cache_read_addr = 1'b0;
always @(posedge i_clk) begin
    if (i_new_pc || invalid_bus_cycle || (o_v && cache_read_addr && i_stall_n)) begin
        cache_read_addr <= 1'b0;
    end else if (o_v && i_stall_n) begin
        cache_read_addr <= 1'b1;
    end
end
always @(posedge i_clk) begin
    if (i_new_pc || invalid_bus_cycle) begin
        cache_valid <= 2'b00;
    end else begin
        if (o_v && i_stall_n) begin
            cache_valid[cache_read_addr] <= 1'b0;
        end
        if (o_wb_cyc && i_wb_ack) begin
            cache_valid[cache_write_addr] <= 1'b1;
        end
    end
end
initial o_i = {(32){1'b1}};
always @(posedge i_clk) begin
    if (((i_stall_n) || (!o_v)) && o_wb_cyc && i_wb_ack) begin
        o_i <= i_wb_data;
    end else begin
        o_i <= cache[cache_read_addr];
    end
end
initial o_pc = 0;
always @(posedge i_clk) begin
    if (i_new_pc) begin
        o_pc <= i_pc;
    end else if (o_v && i_stall_n) begin
        o_pc <= o_pc + 1'b1;
    end
end
assign o_v = cache_valid[cache_read_addr];
initial o_illegal = 1'b0;
always @(posedge i_clk) begin
    if (o_wb_cyc && i_wb_err) begin
        o_illegal <= 1'b1;
    end else if (!o_wb_cyc && (i_new_pc || invalid_bus_cycle)) begin
        o_illegal <= 1'b0;
    end
end
endmodule 