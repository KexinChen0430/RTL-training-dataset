module reg_44(
    clk,                
    input__valid,       
    input__payload,     
    input__ready,       
    invalidate,         
    valid,              
    value,              
    rst                 
);
  reg \initial  = 0;
  wire \$1;  
  wire \$3;  
  wire \$5;  
  input clk;
  input [31:0] input__payload;
  output input__ready;
  input input__valid;
  input invalidate;
  input rst;
  output valid;
  reg valid = 1'h0;
  reg \valid$next;
  output [31:0] value;
  reg [31:0] value = 32'd0;
  reg [31:0] \value$next;
  assign \$1  = ~valid;  
  assign \$3  = input__valid & input__ready;  
  assign \$5  = input__valid & input__ready;  
  always @(posedge clk)
    value <= \value$next;
  always @(posedge clk)
    valid <= \valid$next;
  always @* begin
    if (\initial) begin end  
    \valid$next  = valid;    
    casez (invalidate)
      1'h1: \valid$next  = 1'h0;
    endcase
    casez (\$3)
      1'h1: \valid$next  = 1'h1;
    endcase
    casez (rst)
      1'h1: \valid$next  = 1'h0;
    endcase
  end
  always @* begin
    if (\initial) begin end  
    \value$next  = value;    
    casez (\$5)
      1'h1: \value$next  = input__payload;
    endcase
    casez (rst)
      1'h1: \value$next  = 32'd0;
    endcase
  end
  assign input__ready = \$1;
endmodule