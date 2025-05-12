module avlst_n_to_1 #(
    parameter N = 8,          
    parameter DATA_W = 16,    
)(
    input  csi_clk,           
    input  rsi_reset,         
    output asi_ready,         
    input  asi_valid,         
    input  [N*DATA_W-1:0] asi_data, 
    input  aso_ready,         
    output aso_valid,         
    output [DATA_W-1:0] aso_data 
);
reg ready;                    
reg valid;                    
reg [DATA_W-1:0] data;        
reg [DATA_W-1:0] buffer [0:N-1]; 
assign asi_ready = read;      
assign aso_valid = valid;     
assign aso_data = data;       
reg fval;
always@(posedge csi_clk, posedge rsi_reset) begin
    if(rsi_reset == 1'b1)
        fval <= 1'b0;         
    else
        if(asi_valid == 1'b1)
            fval <= 1'b1;     
        if(cnt == 3'h7)
end
genvar i;
generate
    for(i=0; i<N; i++) begin : main
        always@(posedge csi_clk, posedge rsi_reset) begin
            if(rsi_reset == 1'b1)
                buffer[i] <= {DATA_W{1'b0}}; 
            else begin
                if(asi_valid == 1'b1)
                    buffer[i] <= asi_data[(i+1)*DATA_W-1:i*DATA_W]; 
            end
        end
    end
endgenerate
always@(posedge csi_clk, posedge rsi_reset) begin
    if(rsi_reset == 1'b1) begin
        valid <= 1'b0;        
    end
        valid <= fval &
end
always@(posedge csi_clk, posedge rsi_reset) begin
    if(rsi_reset == 1'b1) begin
        data <= {DATA_W{1'b0}}; 
    end
        data <= buffer[cnt];
end
reg [2:0] cnt;
always@(posedge csi_clk, posedge rsi_reset) begin
    if(rsi_reset == 1'b1)
        cnt <= 3'h0;          
    else begin
        if(aso_ready == 1'b1 && src_valid == 1'b1)
            cnt <= cnt+3'h1;   
    end
end
endmodule