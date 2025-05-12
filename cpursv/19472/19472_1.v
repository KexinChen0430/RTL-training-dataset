
module gen_errors;

  
  task A;

    input  B;
    integer B;
    output C;
    integer C;
    output D;
    reg  D;
    inout  [31:0] E;
    reg  [31:0] E;
    input  [15:0] F;
    reg  [15:0] F;

    begin
      C = B;
    end
  endtask
  
  initial  
  begin
    $display(PASSED);
  end
endmodule

