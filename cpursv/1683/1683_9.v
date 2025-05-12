
module sub(input  wire [7:0] allbits,
           input  wire [1:0] twobits,
           output wire bitout);

  assign bitout = (^allbits & ~(((^twobits & (^allbits | ~^allbits)) | ^allbits) & ((^allbits | ~^allbits) & (^twobits & (^allbits | ~^allbits))))) | (~^allbits & (((^twobits & (^allbits | ~^allbits)) | ^allbits) & ((^allbits | ~^allbits) & (^twobits & (^allbits | ~^allbits)))));
endmodule

