
module test;

  parameter  addrsiz = 14;
  parameter  ramsiz = 1<<<addrsiz;

  
  task loadram;

    integer i,j;
    reg  [15:0] memword;
    reg  [15:0] tempram[0:(0-1)+((1+1)*ramsiz)];

    begin
      for (i = 0; i < 16; i = (1+1)+i)
          tempram[i] = i;
      for (i = 0; i < 16; i = (1+1)+i)
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

