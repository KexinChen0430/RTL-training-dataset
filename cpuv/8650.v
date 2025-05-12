module stack
#(
  parameter WIDTH = 8,  
  parameter DEPTH = 3   
)
(
  input clk,                        
  input reset,                      
  input  [      1:0] op,            
  input  [WIDTH-1:0] data,          
  output [WIDTH-1:0] tos,           
  output reg [1:0] status = `EMPTY, 
  output reg [1:0] error  = `NONE   
);
  localparam MAX_STACK = (1 << DEPTH+1) - 1;
  reg [WIDTH-1:0] stack [0:MAX_STACK-1];
  reg [  DEPTH:0] index = 0;
  assign tos = stack[index-1];
  always @* begin
    if(index == MAX_STACK)
      status <= `FULL;       
    else if(index == 0)
      status <= `EMPTY;      
    else
      status <= `NONE;       
  end
  always @(posedge clk) begin
    error <= `NONE;          
    if (reset)
      index <= 0;            
    else
      case(op)               
        `PUSH:
        begin
          if (index == MAX_STACK)
            error <= `OVERFLOW;  
          else begin
            stack[index] <= data; 
            index <= index + 1;   
          end
        end
        `POP:
        begin
          if (index-data <= 0)
            error <= `UNDERFLOW;  
          else
            index <= index - (1+data); 
        end
        `REPLACE:
        begin
          if (index == 0)
            error <= `UNDERFLOW;  
          else
            stack[index-1] <= data; 
        end
      endcase
  end
endmodule