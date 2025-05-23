module datapath (
    output reg [291:0] snapshot, 
    input [25:0] control,        
    input [15:0] constant,       
    input [15:0] data,           
    input clk,                   
    input rst_n                  
);
reg [15:0] R [0:15];            
reg [15:0] BUSD, BUSB, BUSA;    
reg [3:0] DA, AA, BA, FS, SS;   
reg [2:0] SA;                   
reg MB, MD, RW, V, C, N, Z;     
reg [15:0] MUXB, FUResult;      
reg [15:0] tmp16bit, tmp16bit1, tmp16bit2; 
assign {DA, AA, BA, MB, FS, SS, SA, MD, RW} = control;
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        for (integer i = 0; i < 16; i = i + 1) begin
            R[i] <= 0;
        end
    end else begin
        if (RW) begin
            R[DA] <= BUSD;
        end
    end 
end 
always @(*) begin
    if (MB) begin
        MUXB <= constant;
    end else begin
        MUXB <= R[BA];
    end
end
always @(*) begin
    if (!rst_n) begin
        BUSA <= 0;
    end else begin
        BUSA <= R[AA];
    end
end
always @(*) begin
    if (MD) begin
        BUSD <= data;
    end else begin
        BUSD <= FUResult;
    end
end
always @(*) begin
    if (!rst_n) begin
        BUSB <= 0;
    end else begin
        case(SS)
            3'b000: begin
                BUSB <= MUXB >> SA;
            end
            3'b001: begin
                BUSB <= MUXB << SA;
            end
            3'b010: begin
                if (SA == 0) begin
                    BUSB <= MUXB;
                end else begin
                    tmp16bit <= MUXB >> SA;
                    tmp16bit1 <= MUXB << (16 - SA);
                    BUSB <= tmp16bit | tmp16bit1;
                end
            end
            3'b011: begin
                if (SA == 0) begin
                    BUSB <= MUXB;
                end else begin
                    tmp16bit <= MUXB << SA;
                    tmp16bit1 <= MUXB >> (16 - SA);
                    BUSB <= tmp16bit | tmp16bit1;
                end
            end
            3'b100: begin
                BUSB <= MUXB >>> SA;
            end
            default: begin
                BUSB <= MUXB;
            end
        endcase
    end
end
always @(*) begin
    C <= 0;
    V <= 0;
    case (FS)
    endcase
end
always @(*) begin
    if (!rst_n) begin
        N <= 0;
    end else begin
        N <= FUResult[15];
    end
end
always @(*) begin
    if (!rst_n) begin
        Z <= 0;
    end else begin
        Z <= (FUResult == 0);
    end
end
assign snapshot = {V, C, N, Z, R[0], R[1], R[2], R[3], R[4], R[5], R[6], R[7], R[8], R[9], R[10], R[11], R[12], R[13], R[14], R[15], BUSA, BUSB};
endmodule