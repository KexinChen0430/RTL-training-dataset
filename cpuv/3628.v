module BUFGMUX(O,I0,I1,S);
    input I0, I1, S; 
    output O; 
    assign #1 O = (S) ? I1 : I0; 
endmodule