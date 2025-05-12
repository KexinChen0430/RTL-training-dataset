module check (
    input unsigned [22:0] a, 
    input unsigned [22:0] b, 
    input unsigned [45:0] c  
);
wire unsigned [45:0] int_AB;
assign int_AB = a * b;
always @(a, b, int_AB, c) begin
    #1; 
    if (int_AB !== c) begin
        $display("ERROR"); 
        $finish; 
    end
end
endmodule 