
module count_up(output reg [2:0] count);

  
  initial  
  begin
    #1 count = 0;
    #1 count = 1;
    #1 count = 2;
    #1 count = 3;
  end
endmodule

