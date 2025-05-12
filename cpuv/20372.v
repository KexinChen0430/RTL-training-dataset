module simple_pic (
    input             clk,  
    input             rst,  
    input       [7:0] intv, 
    input             inta, 
    output            intr, 
    output reg  [2:0] iid   
  );