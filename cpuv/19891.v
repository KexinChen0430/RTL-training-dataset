module GP_OBUFT(
    input IN,   
    input OE,   
    output OUT  
);
assign OUT = OE ? IN : 1'bz; 
endmodule 