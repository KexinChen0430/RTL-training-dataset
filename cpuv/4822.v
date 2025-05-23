module SHA1_out(
    input clk,          
    input rst,          
    input start,        
    input [159:0]digest_in, 
    output reg done,    
    output reg [31:0]hash_out 
);
reg [2:0]count; 
always@(posedge clk or negedge rst) begin
    if(rst == 0) begin
        done <= 0;
        hash_out <= 0;
        count <= 0;
    end else begin
        if(start) begin
            if(count < 6)
                count <= count + 1;
        end
    end
end
always@(count) begin
    if(count == 1) begin
        done = 1;
        hash_out = digest_in[31:0];
    end
    else if(count == 2) begin
        hash_out = digest_in[63:32];
    end
    else if(count == 3) begin
        hash_out = digest_in[95:64];
    end
    else if(count == 4) begin
        hash_out = digest_in[127:96];
    end
    else if(count == 5) begin
        hash_out = digest_in[159:128];
    end
    else if (count == 6) begin
        done = 0;
        hash_out = 0;
    end
    else begin
    end
end
endmodule