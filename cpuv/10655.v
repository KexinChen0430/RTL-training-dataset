module ReluQuant #(parameter INPUT = 32, OUTPUT = 8, DEPTH = 256) (data_in, data_out);
input  [INPUT-1:0] data_in [DEPTH-1:0];
output reg [OUTPUT-1:0] data_out [DEPTH-1:0];
reg [OUTPUT-1:0] temp [DEPTH-1:0];
always @(data_in) begin
    for (integer i = 0; i < DEPTH; i++) begin
        if (DEPTH == 256) begin
            temp[i] = data_in[i] >> 12;
        end 
        else if (DEPTH == 32) begin
            temp[i] = data_in[i] >> 8;
        end
        else begin
            temp[i] = data_in[i] >> 12;
        end
    end
end
always @(temp) begin
    for (integer i = 0; i < DEPTH; i++) begin
        data_out[i] = ((temp[i] & 8'h40) | (temp[i] & 8'h80)) ? 0 : temp[i];
    end
end
endmodule