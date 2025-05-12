module quadrature_decode( 
    reset, 
    quadA, 
    quadB, 
    count  
);
    input reset, quadA, quadB; 
    output [15:0] count; 
    initial begin 
        reset = 1; 
        quadA = 1; 
        quadB = 0; 
        #2 
        reset = 0; 
        # 10 
        quadA = 1; 
        quadB = 1; 
        # 10 
        quadA = 0; 
        quadB = 1; 
        # 10 
        quadA = 0; 
        quadB = 0; 
        # 10 
        quadA = 1; 
        quadB = 0; 
        # 10 
        quadA = 1; 
        quadB = 1; 
        # 10 
        quadA = 1; 
        quadB = 0; 
        # 10 
        quadA = 0; 
        quadB = 0; 
        # 2 
        quadA = 1; 
        quadB = 1; 
        # 2 
        quadA = 0; 
        quadB = 0; 
        # 10 
        quadA = 0; 
        quadB = 1; 
    end 
endmodule 