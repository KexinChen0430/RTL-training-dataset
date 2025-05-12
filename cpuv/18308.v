module Abc 
  #(
    parameter No1 = 6, 
    parameter int unsigned No2 
                           = pa_Abc::No2, 
    parameter bit          No3 [No1:0][No2-1:0] 
    = pa_Abc::No3 
    )
   (
    input logic                 ck, 
    input logic [No1-1:0][31:0] abc 
    input logic [No1-1:0][31:0] abc 
    );
endmodule 