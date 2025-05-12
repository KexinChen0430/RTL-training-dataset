module dffse(
    output reg Q,    
    input D,         
    (* clkbuf_sink *)            
    (* invertible_pin = "IS_C_INVERTED" *) 
    input C,         
    input S,         
    input E          
);
    parameter [0:0] INIT = 1'b0;          
    parameter [0:0] IS_C_INVERTED = 1'b0; 
    initial Q = INIT;
    case(|IS_C_INVERTED) 
        1'b0: 
            always @(posedge C or negedge S) 
              if (S) 
                Q <= 1'b1;
              else if(E) 
                Q <= D;
        1'b1: 
            always @(negedge C or negedge S) 
              if (S) 
                Q <= 1'b1;
              else if(E) 
                Q <= D;
    endcase
endmodule