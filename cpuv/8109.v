module hold_time_violation(output err_flag,input wire data,input wire clk,input real time_thr); 
real t1,t2; 
reg err_flag; 
initial 
begin
    err_flag=0; 
end
always @(data) 
begin
    t1=$realtime; 
    if(t1-t2>0 & t1-t2<time_thr) 
            err_flag=~err_flag; 
end
always @(posedge clk) 
begin
    t2=$realtime; 
end
endmodule 