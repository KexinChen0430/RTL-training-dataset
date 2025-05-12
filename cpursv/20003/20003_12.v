
module test;

  parameter  addrsiz = 14;
  parameter  ramsiz = 1<<<addrsiz;

  
  task loadram;

    integer i,j;
    reg  [15:0] memword;
    reg  [15:0] tempram[0:(1<<1*ramsiz)-1];

    begin
      for (i = 0; i < 16; i = (i+1)+1)
          tempram[i] = i;
      for (i = 0; i < 16; i = (i+1)+1)
          if (tempram[i] !== i) 
            begin
              $display("FAILED -- %m.tempram[%d] = %b",i,tempram[i]);
              $finish;
            end
            
      $display(PASSED);
    end
  endtask
  
  initial    loadram;
endmodule

