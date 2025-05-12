
module sub(input  wire [7:0] allbits,
           input  wire [1:0] twobits,
           output wire bitout);

  assign bitout = ((^twobits | ~^twobits) & (^twobits & (^allbits | ~^allbits))) ^ ^allbits;
endmodule

