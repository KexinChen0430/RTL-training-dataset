module ExampMain
  ( input clk, 
    input       a_req_dat, 
    output      a_out, 
    input       a_req_val, 
    output      b_out, 
    input       b_req_val, 
    input [7:0] b_req_dat 
    );
   ExampleIf ia; 
   ExampleIf ib; 
   assign a_out = 1; 
   assign a_out = ia.out; 
   assign ia.req_dat = a_req_dat; 
   assign ia.req_val = a_req_val; 
   assign b_out = ib.out; 
   assign ib.req_dat = b_req_dat; 
   assign ib.req_val = b_req_val; 
endmodule 