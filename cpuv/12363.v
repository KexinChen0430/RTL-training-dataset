module io_ring (
    input OE, 
    input [`WIDTH-1:0] A, 
    output [`WIDTH-1:0] O, 
    inout [`WIDTH-1:0] PAD 
);
   io io[`WIDTH-1:0] (.OE(OE), .I(A), .O(O), .PAD(PAD)); 
endmodule 