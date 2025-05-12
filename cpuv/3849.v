module OBUFT (O, I, T);
    parameter CAPACITANCE = "DONT_CARE"; 
    parameter integer DRIVE = 12;        
    parameter IOSTANDARD = "DEFAULT";    
    parameter SLEW = "SLOW";             
    output O; 
    input  I; 
    input  T; 
    bufif0 T1 (O, I, T);
    initial begin
        case (CAPACITANCE)
            "LOW", "NORMAL", "DONT_CARE" : ;
            default : begin
                          $display("Attribute Syntax Error : The attribute CAPACITANCE on OBUFT instance %m is set to %s.  Legal values for this attribute are DONT_CARE, LOW or NORMAL.", CAPACITANCE);
                          $finish; 
                      end
        endcase
    end
endmodule