module foo
#(
    parameter WIDTH = 32 
)
(
    input CLK 
);
    logic [ ( ( WIDTH + 7 ) / 8 ) * 8 - 1 : 0 ] initial_value;
    logic [ WIDTH - 1 : 0 ] value_q ;
    integer i; 
    initial begin
        initial_value = '1; 
        for (i = 0; i < WIDTH / 8; i++)
            initial_value[ i * 8 +: 8 ] = i[ 7 : 0 ];
        value_q = initial_value[ WIDTH - 1 : 0 ];
    end
    always @(posedge CLK)
        value_q <= ~value_q; 
endmodule