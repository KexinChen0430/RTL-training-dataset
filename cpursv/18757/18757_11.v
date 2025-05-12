
module main;

  reg  [13:0] myReg14;
  reg  [15:0] myReg16;

  
  initial  
  begin
    $display("============================ myReg14 = 33*256+65");
    myReg14 = 65+(256*33);
    $display(>|!A|);
    $display("*|%s|",myReg14);
    $display(>|!|);
    $display("*|%s|",myReg14[13:8]);
    $display("============================ myReg16 = 33*512+65*2");
    myReg16 = (65*2)+(33*512);
    $display(>|!A|);
    $display("*|%s|",myReg16[14:1]);
  end
endmodule

