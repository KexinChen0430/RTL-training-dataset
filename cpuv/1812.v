module `MUX4_1_MS`
    reg x0 = 0; 
    reg x1 = 0; 
    wire y;     
    reg x2 = 0; 
    reg x3 = 0; 
    reg s0 = 0; 
    reg s1 = 0; 
    wire [68:0] x0TV; 
    wire [68:0] x1TV; 
    wire [68:0] x2TV; 
    wire [68:0] x3TV; 
    wire [68:0] s0TV; 
    wire [68:0] s1TV; 
    wire MUX4_1_MS0_0_x0x1_yWire; 
    wire MUX4_1_MS0_0_MUX2_1_Combo1_0_1_y; 
    assign x0TV = 69'd2296870857426870268;
    assign x1TV = 69'd34723282962276803050;
    assign x2TV = 69'd118059162071741130356;
    assign x3TV = 69'd196765270119568550582;
    assign s0TV = 69'd137438953451;
    assign s1TV = 69'd9007061817884663;
    assign MUX4_1_MS0_0_x0x1_yWire = (((!s0) && x0) | (s0 && x1));
    assign MUX4_1_MS0_0_MUX2_1_Combo1_0_1_y = (((!s0) && x2) | (s0 && x3));
    assign y = (((!s1) && MUX4_1_MS0_0_x0x1_yWire) | (s1 && MUX4_1_MS0_0_MUX2_1_Combo1_0_1_y));
    always @(x0, x3, s0, x2, y, x1, s1) begin: MUX4_1_MS_TBV_PRINT_DATA
        $write("%h", x0);
        $write(" ");
        $write("%h", x1);
        $write(" ");
        $write("%h", x2);
        $write(" ");
        $write("%h", x3);
        $write(" ");
        $write("%h", s0);
        $write(" ");
        $write("%h", s1);
        $write(" ");
        $write("%h", y);
        $write("\n");
    end
    initial begin: MUX4_1_MS_TBV_STIMULES
        integer i;
        for (i=0; i<69; i=i+1) begin
            x0 <= x0TV[i]; 
            x1 <= x1TV[i]; 
            x2 <= x2TV[i]; 
            x3 <= x3TV[i]; 
            s0 <= s0TV[i]; 
            s1 <= s1TV[i]; 
            # 1; 
        end
        $finish; 
    end
endmodule