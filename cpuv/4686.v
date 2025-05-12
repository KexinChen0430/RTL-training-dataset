module alu #(
    parameter d_width = 32, 
    op_width = 3            
)
(
    output reg [d_width-1:0] res, 
    input [d_width-1:0] ra,       
    input [d_width-1:0] rb,       
    input [op_width-1:0] aop      
);
    always @(ra, rb, aop)
        (* full_case, parallel_case *)
        case (aop)
            op.ADD : res <= ra + rb;
            op.AND : res <= ra & rb;
            op.NAND: res <= ra ~& rb;
            op.OR  : res <= ra | rb;
            op.XOR : res <= ra ^ rb;
            op.SGT : res <= (ra > rb) ? 1 : 0;
        endcase
endmodule