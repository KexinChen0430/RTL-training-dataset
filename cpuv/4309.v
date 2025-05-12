module reg_42(
    clk,                
    output__valid,      
    output__payload,    
    output__ready,      
    new_en,             
    new_value,          
    rst                 
);
  reg \initial  = 0;
  wire \$1 ;
  input clk;
  input new_en;
  input [31:0] new_value;
  output [31:0] output__payload;
  input output__ready;
  output output__valid;
  input rst;
  reg [31:0] output__payload = 32'd0;
  reg output__valid = 1'h0;
  reg [31:0] \output__payload$next ;
  reg \output__valid$next ;
  assign \$1  = output__valid & output__ready;
  always @(posedge clk)
    output__payload <= \output__payload$next ;
  always @(posedge clk)
    output__valid <= \output__valid$next ;
  always @* begin
    if (\initial ) begin end
    \output__valid$next  = output__valid;
    casez (\$1 )
      1'h1:
          \output__valid$next  = 1'h0;
    endcase
    casez (new_en)
      1'h1:
          \output__valid$next  = 1'h1;
    endcase
    casez (rst)
      1'h1:
          \output__valid$next  = 1'h0;
    endcase
  end
  always @* begin
    if (\initial ) begin end
    \output__payload$next  = output__payload;
    casez (new_en)
      1'h1:
          \output__payload$next  = new_value;
    endcase
    casez (rst)
      1'h1:
          \output__payload$next  = 32'd0;
    endcase
  end
endmodule