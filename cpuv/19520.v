module all; 
  reg pass; 
  task automatic check; 
    input sig; 
    input val; 
    input [32*8:1] name; 
    begin 
      if (sig !== val) begin 
        $display("FAILED \"%0s\", expected %b, got %b", name, val, sig); 
        pass = 1'b0; 
      end 
    end 
  endtask 
  initial begin 
    pass = 1'b1; 
    #100; 
    if (pass) $display("PASSED"); 
  end 
endmodule 