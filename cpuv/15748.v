module dffsre(
    output reg Q, 
    input D, 
    (* clkbuf_sink *) 
    (* invertible_pin = "IS_C_INVERTED" *) 
    input C, 
    input E, 
    input R, 
    input S 
);
    parameter [0:0] INIT = 1'b0; 
    parameter [0:0] IS_C_INVERTED = 1'b0; 
    initial Q = INIT;
    case(|IS_C_INVERTED) 
          1'b0: 
            always @(posedge C or posedge S or posedge R)
              if (S) 
                Q <= 1'b1; 
              else if (R) 
                Q <= 1'b0; 
              else if (E) 
                Q <= D; 
endmodule 