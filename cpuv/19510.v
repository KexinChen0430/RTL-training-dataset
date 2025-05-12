module main (); 
reg a; 
reg error; 
wire c; 
reg d; 
assign c = a; 
always @(c)
  #5 d <= c; 
always @(posedge d)
     error <= 1'b1; 
initial
  begin
    a =1'b0; 
    error = 1'b0; 
    #10; 
    a = 1'b1; 
    # 3; 
    a = 1'b0; 
    # 10; 
    if(error) 
       $display("FAILED"); 
    else
       $display("PASSED"); 
    #5; 
    $finish; 
  end
endmodule 