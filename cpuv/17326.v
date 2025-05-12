module box(
    (* invertible_pin="INV_A" *)
    input  wire [1:0] A,
    input  wire [1:0] B,
    output wire Y
);
    parameter [1:0] INV_A = 2'b00;
endmodule