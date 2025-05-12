module roi(input clk, input [255:0] din, output [255:0] dout);
    my_RAM64X1D2 #(.LOC("SLICE_X6Y100"))
            dut0(.clk(clk), .din(din[  0 +: 8]), .dout(dout[  0 +: 8]));
    my_RAM64X1D2 #(.LOC("SLICE_X6Y127"))
            dut1(.clk(clk), .din(din[  32 +: 8]), .dout(dout[  32 +: 8]));
    my_RAM64X1D2 #(.LOC("SLICE_X12Y100"))
            dut2(.clk(clk), .din(din[  64 +: 8]), .dout(dout[  64 +: 8]));
    my_RAM64X1D2 #(.LOC("SLICE_X12Y127"))
            dut3(.clk(clk), .din(din[  128 +: 8]), .dout(dout[  128 +: 8]));
endmodule