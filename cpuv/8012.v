module verificador(output reg err, input wire [4:0] Q1, input wire [4:0] Q2, input wire clk);
parameter rev_t=`REV_TIME;
reg a_bool;
initial
begin
    a_bool=0; 
    err=0;    
end
always @(posedge clk)
begin
    #rev_t a_bool=~(Q1==Q2); 
    if(a_bool==1)
    begin
        err=~err; 
        #(`PERIODO/2) err=~err; 
    end
end
endmodule