module srl_fifo_reg #
(
    parameter WIDTH = 8
)
(
    input  wire                       clk,
    input  wire                       rst,
    input  wire                       write_en, 
    input  wire [WIDTH-1:0]           write_data,
    input  wire                       read_en, 
    output wire [WIDTH-1:0]           read_data,
    output wire                       full, 
    output wire                       empty 
);
reg [WIDTH-1:0] data_reg[1:0];
reg valid_reg[1:0];
reg ptr_reg = 0;
reg full_reg = 0;
assign read_data = data_reg[ptr_reg];
assign full = full_reg;
assign empty = ~valid_reg[ptr_reg];
wire [WIDTH-1:0] data_reg_0 = data_reg[0];
wire [WIDTH-1:0] data_reg_1 = data_reg[1];
wire valid_reg_0 = valid_reg[0];
wire valid_reg_1 = valid_reg[1];
reg shift;
integer i;
initial begin
    for (i = 0; i < 2; i = i + 1) begin
        data_reg[i] <= 0;
        valid_reg[i] <= 0;
    end
end
always @(posedge clk) begin
    if (rst) begin
        ptr_reg <= 0;
    end else begin
        full_reg <= ~read_en & ~empty;
        if (~full_reg) begin
            data_reg[0] <= write_data;
            valid_reg[0] <= write_en;
            for (i = 0; i < 1; i = i + 1) begin
                data_reg[i+1] <= data_reg[i];
                valid_reg[i+1] <= valid_reg[i];
            end
            ptr_reg <= valid_reg[0];
        end
        if (read_en) begin
            ptr_reg <= 0;
        end
    end
end
endmodule