module test_submodule #
  (
   parameter A_WL = 16, 
   parameter B_WL = 16  
   )
   (
    input logic                   aclk,       
    input logic signed [A_WL-1:0] a_tdata,    
    input logic                   a_tvalid,   
    input logic signed [B_WL-1:0] b_tdata,    
    input logic                   b_tvalid    
    );
endmodule 