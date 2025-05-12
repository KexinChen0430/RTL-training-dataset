module IBUF_INTERMDISABLE (O, I, IBUFDISABLE, INTERMDISABLE);
    parameter IBUF_LOW_PWR = "TRUE"; 
    parameter IOSTANDARD = "DEFAULT"; 
    parameter SIM_DEVICE = "7SERIES"; 
    parameter USE_IBUFDISABLE = "TRUE"; 
`ifdef XIL_TIMING
    parameter LOC = "UNPLACED"; 
`endif 
    output O; 
    input  I; 
    input  IBUFDISABLE; 
    input  INTERMDISABLE; 
    wire out_val; 
    initial begin
        case (IBUF_LOW_PWR)
            "FALSE", "TRUE" : ; 
            default : begin 
                          $display("Attribute Syntax Error : The attribute IBUF_LOW_PWR on IBUF_INTERMDISABLE instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", IBUF_LOW_PWR);
                          $finish;
                      end
        endcase
        if ((SIM_DEVICE != "7SERIES") &&
            (SIM_DEVICE != "ULTRASCALE")) begin
            $display("Attribute Syntax Error : The attribute SIM_DEVICE on IBUF_INTERMDISABLE  instance %m is set to %s.  Legal values for this attribute are 7SERIES or ULTRASCALE.", SIM_DEVICE);
            $finish;
        end
    end
    generate
        case (SIM_DEVICE)
            "7SERIES" : begin 
                            assign out_val = 1'b1;
                        end
            "ULTRASCALE" : begin 
                            assign out_val = 1'b0;
                        end
        endcase
    endgenerate
    generate
        case (USE_IBUFDISABLE)
            "TRUE" :  begin 
                            assign O = (IBUFDISABLE == 0)? I : (IBUFDISABLE == 1)? out_val  : 1'bx;
                        end
            "FALSE" : begin 
                            assign O = I;
                        end
        endcase
    endgenerate
`ifdef XIL_TIMING
    specify
        (I => O)               = (0:0:0,  0:0:0);
        (IBUFDISABLE => O)     = (0:0:0,  0:0:0);
        (INTERMDISABLE => O)   = (0:0:0,  0:0:0);
        specparam PATHPULSE$ = 0; 
    endspecify
`endif 
endmodule 