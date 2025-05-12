module dffre(
    output reg Q,    
    input D,         
    input R,         
    input E,         
    (* clkbuf_sink *)            
    (* invertible_pin = "IS_C_INVERTED" *) 
    input C          
);
    parameter [0:0] INIT = 1'b0;           
    parameter [0:0] IS_C_INVERTED = 1'b0;  
    initial Q = INIT;
    case(|IS_C_INVERTED) 
          1'b0: 
            always @(posedge C or posedge R)
              if (R) 
                Q <= 1'b0; 
              else if(E) 
                Q <= D; 
          1'b1: 
            always @(negedge C or posedge R)
              if (R) 
                Q <= 1'b0; 
              else if(E) 
                Q <= D; 
        endcase
endmodule