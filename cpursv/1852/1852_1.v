
module xorGatetester(busADD,busA,busB);

  input  [31:0] busADD;
  output reg [31:0] busA,busB;
  parameter  d = 20;

  
  initial  
  begin
    $display("busADD \t busA \t busB \t\t\t ");
    #d ;
  end
  reg  [31:0] i;

  
  initial  
  begin
    $monitor("%b \t %b \t %b \t ",busADD,busA,busB,$time);
    busA = 32'h01010101;
    busB = 32'h01010101;
    #d ;
    busA = 32'h7FFFFFFF;
    busB = 32'h7FFFFFFF;
    #d ;
    busA = 32'h01010101;
    busB = 32'hFFFFFFFF;
    #d ;
    busA = 32'h00000001;
    busB = 32'hF0000000;
    #d ;
    busA = 32'hFFFFFFFF;
    busB = 32'h01010101;
    #d ;
    busA = 32'hF0000000;
    busB = 32'h00000001;
    #d ;
    busA = 32'hFFFFFFFF;
    busB = 32'hFFFFFFFF;
    #d ;
    busA = 32'h90000000;
    busB = 32'h80000000;
    #d ;
    #(d*3) ;
    $stop;
    $finish;
  end
endmodule

