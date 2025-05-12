module InstModule (
   output logic [31:0] so, 
   input        si         
);
assign so = {32{si}};
endmodule 