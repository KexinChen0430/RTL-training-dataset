module OBUF (O, I); 
    parameter CAPACITANCE = "DONT_CARE"; 
    parameter integer DRIVE = 12; 
    parameter IOSTANDARD = "DEFAULT"; 
`ifdef XIL_TIMING
    parameter LOC = " UNPLACED"; 
`endif
    parameter SLEW = "SLOW"; 
    output O; 
    input  I; 
    tri0 GTS = glbl.GTS; 
    bufif0 B1 (O, I, GTS); 
    initial begin
        case (CAPACITANCE)
            "LOW", "NORMAL", "DONT_CARE" : ;
            default : begin
                          $display("Attribute Syntax Error : The attribute CAPACITANCE on OBUF instance %m is set to %s.  Legal values for this attribute are DONT_CARE, LOW or NORMAL.", CAPACITANCE);
                          $finish;
                      end
        endcase
    end
`ifdef XIL_TIMING
    specify
        (I => O) = (0:0:0, 0:0:0); 
        specparam PATHPULSE$ = 0;
    endspecify
`endif
endmodule 