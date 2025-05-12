module serializer (
    input  wire clk,          
    input  wire reset,        
    input  wire [63:0] data,   
    input  wire [7:0] charisk, 
    output wire [15:0] txdata, 
    output wire txcharisk      
);
parameter DATA_WIDTH = 64;
generate
    if (DATA_WIDTH == 16) begin
        serializer_16 ser (
            .clk(clk),
            .reset(reset),
            .data(data[15:0]),
            .charisk(charisk[1:0]),
            .txdata(txdata),
            .txcharisk(txcharisk)
        );
    end else if (DATA_WIDTH == 32) begin
        serializer_32 ser (
            .clk(clk),
            .reset(reset),
            .data(data[31:0]),
            .charisk(charisk[3:0]),
            .txdata(txdata),
            .txcharisk(txcharisk)
        );
    end else if (DATA_WIDTH == 64) begin
        serializer_64 ser (
            .clk(clk),
            .reset(reset),
            .data(data),
            .charisk(charisk),
            .txdata(txdata),
            .txcharisk(txcharisk)
        );
    end else begin
        initial begin
            $display("Error: serializer module works only with 16/32/64 gtx input data width");
            $finish;
        end
    end
endgenerate
assign  txdata_out    = txdata;
assign  txcharisk_out = txcharisk;
endmodule