module f32ToRecF32 (
    input [31:0] in,  
    output [32:0] out 
);
    fNToRecFN#(8, 24) fNToRecFN(
        in,  
        out  
    );
endmodule 