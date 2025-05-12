module reg_07(
  input clk,                
  output reg output__valid, 
  output reg [31:0] output__payload, 
  input output__ready,      
  input new_en,             
  input [31:0] new_value,   
  input rst                 
);
  reg \initial  = 0;
  wire \$1 ;
  reg [31:0] \output__payload$next ;
  reg \output__valid$next ;
  initial begin
    output__payload = 32'd0;
    output__valid = 1'h0;
  end
  assign \$1  = output__valid & output__ready;
  always @(posedge clk) begin
    output__payload <= \output__payload$next ;
  end
  always @(posedge clk) begin
    output__valid <= \output__valid$next ;
  end
  always @* begin
    \output__valid$next  = output__valid;
    casez (\$1 )
      1'h1: \output__valid$next  = 1'h0;
    endcase
    casez (new_en)
      1'h1: \output__valid$next  = 1'h1;
    endcase
    casez (rst)
      1'h1: \output__valid$next  = 1'h0;
    endcase
  end
  always @* begin
    \output__payload$next  = output__payload;
    casez (new_en)
      1'h1: \output__payload$next  = new_value;
    endcase
    casez (rst)
      1'h1: \output__payload$next  = 32'd0;
    endcase
  end
endmodule