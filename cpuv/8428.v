module fme_abs (
    a_i,
    b_o
);
parameter INPUT_BITS = `PIXEL_WIDTH;
input     [INPUT_BITS-1 : 0] a_i;
output    [INPUT_BITS-2 : 0] b_o;
wire      [INPUT_BITS-1 : 0] b_o_w ;
assign b_o_w = ({(INPUT_BITS-1){a_i[INPUT_BITS-1]}} ^ {a_i[INPUT_BITS-2:0]}) + {{(INPUT_BITS-1){1'b0}},a_i[INPUT_BITS-1]};
assign b_o   = b_o_w[INPUT_BITS-2:0];
endmodule