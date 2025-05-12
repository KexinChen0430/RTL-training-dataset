module control(
    input [5:0] op,        
    input [5:0] funct,     
    output reg [1:0] RegDst,   
    output reg RegWrite,        
    output reg ALUSrc,          
    output reg MemRead,         
    output reg MemWrite,        
    output reg MemtoReg,        
    output reg [1:0] Jump,      
    output reg Branch,          
    output reg Equal,           
    output reg JumpLink,        
    output reg [3:0] ALUCtrl    
);
    always @* begin
        case (op)
            6'h08 : begin 
                `CONTROL_SIGNAL <= 12'b0011000000X0; 
                ALUCtrl <= 4'b0001; 
            end
            6'h0C : begin 
                `CONTROL_SIGNAL <= 12'b0011000000X0; 
                ALUCtrl <= 4'b0011; 
            end
            6'h00 : begin 
                case (funct)
                    6'd32 : begin 
                        `CONTROL_SIGNAL <= 12'b0110000000X0; 
                        ALUCtrl <= 4'b0001; 
                    end
                    default : begin
                        `CONTROL_SIGNAL <= 12'b0; 
                        ALUCtrl <= 4'b0; 
                    end
                endcase
            end
            default : begin
                `CONTROL_SIGNAL <= 12'b0; 
                ALUCtrl <= 4'b0; 
            end
        endcase
    end
endmodule