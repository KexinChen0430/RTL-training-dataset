module TRIBUF(
    input in,      
    input enable,  
    output out     
);
assign out = enable ? in : 1'bz;
endmodule 