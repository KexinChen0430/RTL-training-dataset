module add_one(
  input__payload,  
  input__ready,    
  output__valid,   
  output__payload, 
  output__ready,   
  input__valid     
);
  wire [32:0] \$1;
  wire [32:0] \$2;
  input [31:0] input__payload;
  output input__ready;
  input input__valid;
  output [31:0] output__payload;
  input output__ready;
  output output__valid;
  assign \$2  = input__payload + 1'h1;
  assign \$1  = \$2;
  assign output__payload = \$2 [31:0];
  assign output__valid = input__valid;
  assign input__ready = output__ready;
endmodule