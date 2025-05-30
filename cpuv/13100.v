module InstructionMem (
    input [31:0] addr,           
    output reg [31:0] instruction 
);
    parameter ROM_SIZE = 128;     
    parameter ROM_BIT  = 7;       
    always @ (*)
        case (addr[ROM_BIT+1:2]) 
            7'd0: instruction = 32'h08000003;
            7'd1: instruction = 32'h0800004b;
            7'd113: instruction = 32'h35ad0002;
            7'd114: instruction = 32'hae0d0008;
            7'd115: instruction = 32'h03400008;
            default: instruction =32'h8000_0000;
        endcase
endmodule