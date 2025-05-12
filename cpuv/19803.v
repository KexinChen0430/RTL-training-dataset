module main ; 
reg [31:0] value; 
reg control; 
reg clock; 
reg error; 
always @(posedge clock)
  value = 3;
always @(control)
  if(control)
    assign value = 2; 
  else
    deassign value ; 
always begin
         #2; 
         clock = ~clock; 
       end
initial
      begin
        clock = 0; 
        error = 0; 
        # 3; 
        if(value != 3)
          begin
            $display("FAILED - assign3.2C - procedural assignment(1)");
            error = 1; 
          end
        # 2; 
        control = 1; 
        # 1; 
        if(value != 2)
          begin
            $display("FAILED - assign3.2C - procedural assignment(2)");
            error = 1; 
          end
        # 3 ; 
        control = 0; 
        # 2; 
        if(value != 3)
          begin
            $display("FAILED - assign3.2C - procedural assignment(3)");
            error = 1; 
          end
        if(error == 0) $display ("PASSED");
        $finish ; 
      end
endmodule 