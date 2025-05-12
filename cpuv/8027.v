module setup_time_violation(output err_flag,input wire data,input wire clk,input real time_thr); 
real t1,t2; 
reg err_flag; 
initial 
begin
    err_flag=0; 
end
always @(data) 
begin
    t1=$realtime; 
end
always @(posedge clk) 
begin
    t2=$realtime; 
    if(t2-t1>=0 & t2-t1<time_thr) 
            err_flag=~err_flag; 
end
endmodule 