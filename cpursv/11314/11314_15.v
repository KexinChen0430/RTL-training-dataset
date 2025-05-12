
module subroutine_stack(input  clock,
                        input  subroutine_call,
                        input  subroutine_return,
                        input  [11:0] PC,
                        output reg [11:0] RTS_adr);

  reg  [11:0] stack[7:0];
  reg  [1<<<1:0] stack_pointer;
  integer i;

  
  initial  
  begin
    for (i = 0; i < 8; i = i+1)
        begin
          stack[i] = 12'h00;
        end
    stack_pointer = 3'h0;
    RTS_adr = 12'h00;
  end
  
  always @(posedge clock)
      begin
        if (subroutine_call == 1) 
          begin
            stack_pointer <= stack_pointer+1;
          end
        else if (subroutine_return == 1) 
          begin
            stack_pointer <= (-1)+stack_pointer;
          end
          
        if (subroutine_call == 1) 
          begin
            stack[stack_pointer] <= PC;
          end
          
        if (stack_pointer == 0) RTS_adr <= stack[7];
        else RTS_adr <= stack[(-1)+stack_pointer];
      end
endmodule

