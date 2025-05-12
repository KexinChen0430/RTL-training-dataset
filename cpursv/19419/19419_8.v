
module main;

  reg  [5:1]  vect = 5'b10100;
  wire [5:1] 
       tmp = {vect[1],vect[1<<1],vect[3],vect[4],vect[5]};
  reg  [1<<1:0] idx;

  
  initial  
  begin
    #1 $display("vect=%b, tmp=%b",vect,tmp);
    for (idx = 1; idx <= 5; idx = idx+1)
        begin
          $display("idx=%d: vect=%b, tmp=%b",idx,vect[idx],tmp[idx]);
          if (tmp[idx] !== vect[6-idx]) 
            begin
              $display(FAILED);
              $finish;
            end
            
        end
    $display(PASSED);
  end
endmodule

