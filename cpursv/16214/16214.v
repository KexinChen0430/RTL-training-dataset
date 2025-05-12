
module using_hierarchical_references_and_concatenation;

  reg  [1:0] temp;

  
  initial  
  begin
    temp = 2'h3;
    top.memory.memory[1] = {2'h0,temp};
    top.memory.memory[1] = {top.memory.memory[1],temp};
    $display("top.memory.memory[1] = %h",top.memory.memory[1]);
    if (top.memory.memory[1] != {2{temp}}) 
      begin
        $display("ERROR! top.memory.memory[1] failed to get set correctly!");
      end
    else 
      begin
        $display("PASS! top.memory.memory[1] set correctly.");
      end
    $display("top.memory.memory[1] = %h",top.memory.memory[1]);
    $finish(0);
  end
endmodule

