module IOBUF (
    (* iopad_external_pin *) 
    inout IO, 
    output O, 
    input I, 
    input T  
);
    parameter integer DRIVE = 12; 
    parameter IBUF_LOW_PWR = "TRUE"; 
    parameter IOSTANDARD = "DEFAULT"; 
    parameter SLEW = "SLOW"; 
    assign IO = T ? 1'bz : I; 
    assign O = IO; 
    specify
        (I => IO) = 0; 
        (IO => O) = 0; 
    endspecify
endmodule