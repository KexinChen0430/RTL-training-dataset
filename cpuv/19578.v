module main; 
reg globvar; 
reg [7:0] var1,var2,var3; 
reg error; 
reg [7:0] value; 
always @(var1 or var2) 
   value = var1 >> var2; 
initial 
  begin
    error = 0; 
    #1 ; 
    var1 = 8'h80; 
    var2 = 8'h7; 
    #1; 
    if(value !== 8'h1) 
      begin
        error = 1; 
	$display ("FAILED - 80 >> 7 is %h",value); 
      end
endmodule 