
module main;

  reg  [5:0] a;
  reg  error;
  wire [3:0]  val1 = a[4] ? a[3:0] : 4'd0;
  wire [3:0]  val2 = a[4] ? 4'hf : ~a[3:0];

  
  initial  
  begin
    error = 0;
    for (a = 0; a < 32; a = a+1)
        begin
          #1 ;
          if (
(((val2 != 15) || (val1 != a[3:0])) && 
(
((val2 != 15) || ((val1 != 0) || (val1 != a[3:0]))) && ((val1 != 0) || a[4]) && 
((a[4] && (val1 != a[3:0])) || (val2 != 15))) && 
(
(!a[4] || 
(
((val2 != 15) || ((val1 != 0) || (val1 != a[3:0]))) && ((val1 != 0) || a[4]) && 
((a[4] && (val1 != a[3:0])) || (val2 != 15)))) && a[4])) || 
              ((!a[4] || (val2 != ~a[3:0])) && 
((val2 != ~a[3:0]) || ((val1 != 0) || a[4])) && !a[4] && 
((val2 != 15) || 
((a[4] && (val1 != a[3:0])) || (val2 != ~a[3:0])) || (val1 != 0)))) 
            begin
              $display("FAILED  a=%b, val1=%b, val2=%b",a[4:0],val1,
                       val2);
              error = 1;
            end
            
        end
    if (error == 0) 
      $display(PASSED);
      
  end
endmodule

