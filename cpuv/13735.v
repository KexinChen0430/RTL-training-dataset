module ula( opcode,     
            data1,      
            data2,      
            out,        
            rflags      
);
`include "params_proc.v"
input [OPCODE_WIDTH-1:0] opcode; 
input signed [DATA_WIDTH-1:0] data1, data2; 
output reg signed [DATA_WIDTH-1:0] out; 
output reg [RFLAGS_WIDTH-1:0] rflags; 
reg xor_data12_sign; 
reg signed [DATA_WIDTH-1:0] data2_aux; 
always @(*) begin
    out = data1; 
    rflags = 0; 
    data2_aux = 0; 
    xor_data12_sign = data1[DATA_WIDTH-1] ^ data2[DATA_WIDTH-1]; 
    if (opcode == ADD || opcode == SUB || opcode == CMP) begin
        data2_aux = (opcode == SUB || opcode == CMP ? (~ data2) + 1 : data2);
        out = data1 + data2_aux; 
        case(out[DATA_WIDTH-1])
        1'b0: begin
            if (data1[DATA_WIDTH-1] == 1 && data2_aux[DATA_WIDTH-1] == 1) begin
                rflags[4] = 1; 
            end
        end
        default: begin
            if (data1[DATA_WIDTH-1] == 0 && data2_aux[DATA_WIDTH-1] == 0) begin
                rflags[4] = 1; 
            end
        end
        endcase
    end else if (opcode == MUL) begin
        out = data1 * data2; 
        case(out[DATA_WIDTH-1])
        1'b0: begin
            if (xor_data12_sign == 1) begin
                rflags[4] = 1; 
            end
        end
        default: begin
            if (xor_data12_sign == 0) begin
                rflags[4] = 1; 
            end
        end
        endcase
    end else if (opcode == DIV) begin
        if (data2 != 0) begin
            out = data1 / data2; 
        end else begin
            rflags[0] = 1; 
        end
    end else if (opcode == AND) begin
        out = data1 & data2; 
    end else if (opcode == OR) begin
        out = data1 | data2; 
    end else if (opcode == NOT) begin
        out = (data1 == 0 ? 1 : 0) ; 
    end
    if (opcode == CMP) begin
        if (out == 0) begin
            rflags = 5'b00100; 
        end else if (xor_data12_sign) begin
            if (data1[DATA_WIDTH-1]) begin
                rflags = 5'b00010; 
            end else begin
                rflags = 5'b01000; 
            end
        end else begin
            if (out[DATA_WIDTH-1]) begin
                rflags = 5'b00010; 
            end else begin
                rflags = 5'b01000; 
            end
        end
    end
end
endmodule