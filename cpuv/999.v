module axis_srl_register_64 #
(
    parameter DATA_WIDTH = 64,
    parameter KEEP_WIDTH = (DATA_WIDTH/8)
)
(
    input  wire                       clk,
    input  wire                       rst,
    input  wire [DATA_WIDTH-1:0]  input_axis_tdata,  
    input  wire [KEEP_WIDTH-1:0]  input_axis_tkeep,  
    input  wire                   input_axis_tvalid, 
    output wire                   input_axis_tready, 
    input  wire                   input_axis_tlast,  
    input  wire                   input_axis_tuser,  
    output wire [DATA_WIDTH-1:0]  output_axis_tdata, 
    output wire [KEEP_WIDTH-1:0]  output_axis_tkeep, 
    output wire                   output_axis_tvalid,
    input  wire                   output_axis_tready,
    output wire                   output_axis_tlast, 
    output wire                   output_axis_tuser  
);
reg [DATA_WIDTH+KEEP_WIDTH+2-1:0] data_reg[1:0]; 
reg valid_reg[1:0];                              
reg ptr_reg = 0;                                 
reg full_reg = 0;                                
assign {output_axis_tlast, output_axis_tuser, output_axis_tkeep, output_axis_tdata} = data_reg[ptr_reg];
assign input_axis_tready = ~full_reg;
assign output_axis_tvalid = valid_reg[ptr_reg];
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
        full_reg <= ~output_axis_tready & output_axis_tvalid;
        if (input_axis_tready) begin
            data_reg[0] <= {input_axis_tlast, input_axis_tuser, input_axis_tkeep, input_axis_tdata};
            valid_reg[0] <= input_axis_tvalid;
            for (i = 0; i < 1; i = i + 1) begin
                data_reg[i+1] <= data_reg[i];
                valid_reg[i+1] <= valid_reg[i];
            end
            ptr_reg <= valid_reg[0];
        end
        if (output_axis_tready) begin
            ptr_reg <= 0;
        end
    end
end
endmodule