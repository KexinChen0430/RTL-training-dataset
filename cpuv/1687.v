module ALU (
    input  [  `ALU_DATA_WIDTH-1:0] wIn         , 
    input  [  `ALU_DATA_WIDTH-1:0] fIn         , 
    input  [  `ALU_DATA_WIDTH-1:0] lIn         , 
    input  [  `ALU_FUNC_WIDTH-1:0] funcIn      , 
    input  [                  2:0] bitSel      , 
    input                          cFlag       , 
    input  [`ALU_STATUS_WIDTH-1:0] statusIn    , 
    output [`ALU_STATUS_WIDTH-1:0] aluStatusOut, 
    output [  `ALU_DATA_WIDTH-1:0] aluResultOut  
);
reg C3; 
reg carry; 
reg [`ALU_DATA_WIDTH-1:0] result; 
assign aluResultOut = result;
always @(*) begin
    C3 = 1'b0; 
    carry = 1'b0; 
    case (funcIn) 
        `ALU_ADDWF: begin 
            {C3,result[3:0]} = fIn[3:0] + wIn[3:0];
            {carry,result[7:4]} = fIn[7:4] + wIn[7:4] + C3;
        end
        `ALU_SUBWF: begin 
            {C3,result[3:0]} = fIn[3:0] - wIn[3:0];
            {carry,result[7:4]} = fIn[7:4] - wIn[7:4] - C3;
        end
        `ALU_RLF: begin 
            {carry, result} = {fIn[`ALU_DATA_WIDTH-1:0], cFlag};
        end
        default: begin
            result = 8'hEF; 
        end
    endcase
end
always@(*) begin
    case (funcIn) 
        `ALU_ADDWF:begin
            status = {(result == 8'b0), 1'b0, 1'b0} | {1'b0, C3, carry};
        end
        default: begin
            status = {(result == 8'b0), statusIn[1:0]};
        end
    endcase
end
endmodule 