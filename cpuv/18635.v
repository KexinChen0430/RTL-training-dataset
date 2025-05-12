module stimulus (output reg A, B); 
  initial begin 
    #0  {A, B} = 2'bxx; 
    #10 {A, B} = 2'bzz; 
    #10 {A, B} = 2'b0x; 
    #10 {A, B} = 2'bx0; 
    #10 {A, B} = 2'b0z; 
    #10 {A, B} = 2'bz0; 
    #10 {A, B} = 2'b1x; 
    #10 {A, B} = 2'bx1; 
    #10 {A, B} = 2'b1z; 
    #10 {A, B} = 2'bz1; 
    #10 {A, B} = 2'b00; 
    #10 {A, B} = 2'b01; 
    #10 {A, B} = 2'b10; 
    #10 {A, B} = 2'b11; 
  end 
endmodule 