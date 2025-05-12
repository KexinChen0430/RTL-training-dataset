module parameter_test; 
parameter   foo_size    = 32 * 6;
parameter   foo_lsb     = 0;
`ifdef GOOD_CODE
    parameter   foo_msb_temp    = foo_lsb + foo_size;
    parameter   foo_msb         = foo_msb_temp - 1;
`else
    parameter   foo_msb         = foo_lsb + foo_size - 1;
`endif
parameter temp0 = 1 + 2 + 3 + 4 + 5;
parameter temp1 = 1 + 2 + 3 + 4 + 5 - 1;
reg [foo_msb:foo_lsb] foo;
integer i;
initial begin
    for (i=0; i<foo_size; i=i+1) begin
        foo[i] = 1;
    end
    $write("foo = %0h\n", foo);
    $finish(0);
end
endmodule 