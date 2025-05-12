
module test();

  parameter  init = 16'h1234;
  reg  [15:0] rcv;

  
  initial  
  begin
    #10 ;
    rcv = init;
    $display("Init value is %h",rcv);
  end
endmodule

