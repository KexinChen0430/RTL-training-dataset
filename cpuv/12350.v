module sc_mux3_d_27 (out,in0,sel0,in1,sel1,in2,sel2) ;
    output [26:0] out ;
    input  [26:0] in0,in1,in2 ;
    input sel0,sel1,sel2 ;
    reg [26:0] out ;
    wire [2:0] select = {sel0,sel1,sel2} ;
    always @ (select or in0 or in1 or in2)
        case (select) 
            3'b100: out = in0;
            3'b010: out = in1;
            3'b001: out = in2 ;
            default: out = 27'hx;
        endcase
endmodule