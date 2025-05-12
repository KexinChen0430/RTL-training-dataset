module \$_DFF_N_ (D, C, Q); 
input D, C;                 
output reg Q;               
always @(negedge C) begin   
	Q <= D;                
end                         
endmodule                    