module main ; 
reg [31:0] value; 
reg [1:0] control; 
reg clock; 
reg error; 
always @(posedge clock)
  value = 3; 
always @(control)
  if(control == 1) 
    assign value = 1; 
  else
  if(control == 2) 
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
            $display("FAILED - deassign3.4A - procedural assignment(1)"); 
            error = 1; 
          end
        # 2; 
        control = 1; 
        # 1; 
        if(value != 1) 
          begin
            $display("FAILED - deassign3.4A - procedural assignment(2)"); 
            error = 1; 
          end
        # 1 ; 
        control = 2; 
        # 1 ; 
        if(value != 2) 
          begin
            $display("FAILED - deassign3.4A - procedural assignment(3)"); 
            error = 1; 
          end
        #1 ; 
        control = 0; 
        # 10; 
        if(value != 3) 
          begin
            $display("FAILED - deassign3.4A - procedural assignment(4)"); 
            error = 1; 
          end
        if(error == 0) $display ("PASSED"); 
        $finish ; 
      end
endmodule 