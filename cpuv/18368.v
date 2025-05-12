module test_top # 
  (
    parameter int A_WL = 16, 
    parameter int B_WL = 32  
    )
   (
    input logic                    aclk,      
    input logic signed [A_WL-1:0]  a_tdata,   
    input logic                    a_tvalid,  
    input logic signed [B_WL-1:0]  b_tdata,   
    input logic                    b_tvalid   
    );
   test_submodule 
      #() 
   test_submodule_inst 
      (); 
endmodule 