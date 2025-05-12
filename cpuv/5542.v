module axis_srl_fifo # 
(
    parameter DATA_WIDTH = 8, 
    parameter DEPTH = 16 
)
(
    input  wire                       clk, 
    input  wire                       rst, 
    input  wire [DATA_WIDTH-1:0]  input_axis_tdata, 
    input  wire                   input_axis_tvalid, 
    output wire                   input_axis_tready, 
    input  wire                   input_axis_tlast, 
    input  wire                   input_axis_tuser, 
    output wire [DATA_WIDTH-1:0]  output_axis_tdata, 
    output wire                   output_axis_tvalid, 
    input  wire                   output_axis_tready, 
    output wire                   output_axis_tlast, 
    output wire                   output_axis_tuser, 
    output wire [$clog2(DEPTH+1)-1:0] count 
);
reg [DATA_WIDTH+2-1:0] data_reg[DEPTH-1:0]; 
reg [$clog2(DEPTH+1)-1:0] ptr_reg = 0, ptr_next; 
reg full_reg = 0, full_next; 
reg empty_reg = 1, empty_next; 
assign {output_axis_tlast, output_axis_tuser, output_axis_tdata} = data_reg[ptr_reg-1]; 
assign input_axis_tready = ~full_reg; 
assign output_axis_tvalid = ~empty_reg; 
assign count = ptr_reg; 
wire ptr_empty = ptr_reg == 0; 
wire ptr_empty1 = ptr_reg == 1; 
wire ptr_full = ptr_reg == DEPTH; 
wire ptr_full1 = ptr_reg == DEPTH-1; 
reg shift; 
reg inc; 
reg dec; 
integer i; 
initial begin
    for (i = 0; i < DEPTH; i = i + 1) begin
        data_reg[i] <= 0; 
    end
end
always @* begin
    shift = 0; 
    inc = 0; 
    dec = 0; 
    ptr_next = ptr_reg; 
    full_next = full_reg; 
    empty_next = empty_reg; 
    if (output_axis_tready & input_axis_tvalid & ~full_reg) begin
        shift = 1; 
        inc = ptr_empty; 
        empty_next = 0; 
    end else if (output_axis_tready & output_axis_tvalid) begin
        dec = 1; 
        full_next = 0; 
        empty_next = ptr_empty1; 
    end else if (input_axis_tvalid & input_axis_tready) begin
        shift = 1; 
        inc = 1; 
        full_next = ptr_full1; 
        empty_next = 0; 
    end
end
always @(posedge clk) begin
    if (rst) begin
        ptr_reg <= 0; 
    end else begin
        if (shift) begin
            data_reg[0] <= {input_axis_tlast, input_axis_tuser, input_axis_tdata}; 
            for (i = 0; i < DEPTH-1; i = i + 1) begin
                data_reg[i+1] <= data_reg[i]; 
            end
        end
        if (inc) begin
            ptr_reg <= ptr_reg + 1; 
        end else if (dec) begin
            ptr_reg <= ptr_reg - 1; 
        end else begin
            ptr_reg <= ptr_reg; 
        end
        full_reg <= full_next; 
        empty_reg <= empty_next; 
    end
end
endmodule