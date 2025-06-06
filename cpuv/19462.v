module FFD_POSEDGE_SYNCRONOUS_RESET # ( parameter SIZE=`WIDTH )
(
    input wire              Clock,   
    input wire              Reset,   
    input wire              Enable,  
    input wire [SIZE-1:0]   D,       
    output reg [SIZE-1:0]   Q        
);
always @ (posedge Clock)
begin
    if (Reset) 
        Q <= {SIZE{1'b0}}; 
    else 
    begin
        if (Enable) 
            Q <= D; 
    end
end 
endmodule 