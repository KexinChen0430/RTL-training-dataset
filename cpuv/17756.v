module buffer
#(parameter buffersize = 8)
(
    input `control_w in,       
    input clk,                 
    input rst,                 
    output `control_w out,     
    input push,                
    input pop,                 
    output full,               
    output [2:0] bsize         
);
    reg [2:0] head, tail;      
    reg [2:0] size;            
    integer n;
    reg `control_w rf[buffersize-1:0]; 
    always @ rst begin
        head <= 0;             
        tail <= 0;             
        size <= 0;             
        for (n = 0; n < 8; n = n + 1) 
            rf[n] <= 0;
    end
    assign out = rf[head];     
    assign full = (size == 7); 
    assign bsize = size;       
    always @ (posedge clk) begin
        if (push && pop) begin 
            rf[tail] <= in;    
            tail <= tail + 1;  
            head <= head + 1;  
        end
        else if (push) begin   
            rf[tail] <= in;    
            tail <= tail + 1;  
            size <= size + 1;  
        end
        else if (pop) begin    
            head <= head + 1;  
            size <= size - 1;  
        end
        else
            ; 
    end
endmodule