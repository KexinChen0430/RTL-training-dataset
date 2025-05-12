module time2 (); 
reg [3:0] clock; 
reg [3:0] b; 
reg [3:0] count; 
initial 
  begin
    b = 4'b1111; 
    count = 0; 
    for (clock = 0; clock<=10; clock = clock + 1) 
       begin
        $display("time = %t, clock = %h",$time,clock); 
        #10; 
       end
  end
always @(posedge clock & b) 
  begin
    count = count+1; 
    $display(" edge ! time = %t, count = %h",$time,count); 
  end
initial 
  begin
    #1000; 
    if(count != 6) 
        $display("FAILED - vect[0] clock detect count=%d",count); 
    else
        $display("PASSED"); 
  end
endmodule 