module dffs(
    output reg Q,    
    input D,         
    (* clkbuf_sink *)            
    (* invertible_pin = "IS_C_INVERTED" *) 
    input C,         
    input S          
);
    parameter [0:0] INIT = 1'b0;          
    parameter [0:0] IS_C_INVERTED = 1'b0; 
    initial Q = INIT;
    case(|IS_C_INVERTED) 
        1'b0: 
            always @(posedge C or negedge S)
              if (S) 
                Q <= 1'b1;
              else 
                Q <= D;
        1'b1: 
            always @(negedge C or negedge S)
              if (S) 
                Q <= 1'b1;
              else 
                Q <= D;
    endcase
endmodule