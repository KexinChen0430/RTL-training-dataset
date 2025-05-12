module CARRY_CO_LUT(input CO, input O, input S, input DI, output OUT);
assign OUT = O ^ S;
endmodule