module box( 
    (* invertible_pin="INV_A" *) 
    input  wire A, 
    input  wire B, 
    (* invertible_pin="INV_C" *) 
    input  wire C, 
    input  wire D, 
    output wire Y  
);
    parameter [0:0] INV_A = 1'b0; 
    parameter [0:0] INV_C = 1'b0; 
endmodule 