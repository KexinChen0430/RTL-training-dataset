module tc (
    input vconst, 
    input b,      
    output reg q  
);
always @ (posedge vconst) begin
    q <= b;       
    $stop;        
end
endmodule 