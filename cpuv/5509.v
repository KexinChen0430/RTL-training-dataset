module offset_to_mask 
    #(parameter C_MASK_SWAP = 1, 
      parameter C_MASK_WIDTH = 4) 
    (
     input                            OFFSET_ENABLE, 
     input [clog2s(C_MASK_WIDTH)-1:0] OFFSET, 
     output [C_MASK_WIDTH-1:0]        MASK 
     );
    reg [7:0]                         _rMask,_rMaskSwap; 
    wire [3:0]                        wSelect; 
    assign wSelect = {OFFSET_ENABLE,{{(3-clog2s(C_MASK_WIDTH)){1'b0}},OFFSET}}; 
    assign MASK = (C_MASK_SWAP)? _rMaskSwap[7 -: C_MASK_WIDTH]: _rMask[C_MASK_WIDTH-1:0]; 
    always @(*) begin 
        _rMask = 0; 
        _rMaskSwap = 0; 
        casex(wSelect) 
            default: begin 
                _rMask = 8'b1111_1111; 
                _rMaskSwap = 8'b1111_1111; 
            end
            4'b1000: begin 
                _rMask = 8'b0000_0001; 
                _rMaskSwap = 8'b1111_1111; 
            end
            4'b1001: begin 
                _rMask = 8'b0000_0011; 
                _rMaskSwap = 8'b0111_1111; 
            end
            4'b1010: begin 
                _rMask = 8'b0000_0111; 
                _rMaskSwap = 8'b0011_1111; 
            end
            4'b1011: begin 
                _rMask = 8'b0000_1111; 
                _rMaskSwap = 8'b0001_1111; 
            end
            4'b1100: begin 
                _rMask = 8'b0001_1111; 
                _rMaskSwap = 8'b0000_1111; 
            end
            4'b1101: begin 
                _rMask = 8'b0011_1111; 
                _rMaskSwap = 8'b0000_0111; 
            end
            4'b1110: begin 
                _rMask = 8'b0111_1111; 
                _rMaskSwap = 8'b0000_0011; 
            end
            4'b1111: begin 
                _rMask = 8'b1111_1111; 
                _rMaskSwap = 8'b0000_0001; 
            end
        endcase 
    end
endmodule