module OBUFT (
    (* iopad_external_pin *)
    output O,
    input I,
    input T
);
    parameter CAPACITANCE = "DONT_CARE";
    parameter integer DRIVE = 12;
    parameter IOSTANDARD = "DEFAULT";
    parameter SLEW = "SLOW";
    assign O = T ? 1'bz : I;
    specify
        (I => O) = 0;
    endspecify
endmodule