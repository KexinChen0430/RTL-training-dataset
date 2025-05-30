module mvd_getBits(
    mv_i             ,
    mvp_i            ,
    mv_bits_cnt_o    ,
    mvd_o
);
input    [  2*`FMV_WIDTH-1:0] mv_i               ; 
input    [  2*`FMV_WIDTH-1:0] mvp_i              ; 
output   [             6-1:0] mv_bits_cnt_o      ; 
output   [  2*`MVD_WIDTH-1:0] mvd_o              ; 
wire signed  [`FMV_WIDTH  :0] mv_x               ; 
wire signed  [`FMV_WIDTH  :0] mv_y               ; 
wire signed  [`FMV_WIDTH  :0] mvp_x              ; 
wire signed  [`FMV_WIDTH  :0] mvp_y              ; 
wire signed  [`MVD_WIDTH-1:0] mv_x_diff_temp     ; 
wire signed  [`MVD_WIDTH-1:0] mv_y_diff_temp     ; 
wire signed  [`MVD_WIDTH  :0] mv_x_diff          ; 
wire signed  [`MVD_WIDTH  :0] mv_y_diff          ; 
reg      [             5-1:0] num_x_00           ; 
reg      [             5-1:0] num_x_01           ; 
reg      [             5-1:0] num_x_02           ; 
reg      [             6-1:0] num_x              ; 
reg      [             5-1:0] num_y_00           ; 
reg      [             5-1:0] num_y_01           ; 
reg      [             5-1:0] num_y_02           ; 
reg      [             6-1:0] num_y              ; 
assign   mv_x  = {mv_i [   `FMV_WIDTH-1],mv_i[   `FMV_WIDTH-1:         0]}; 
assign   mv_y  = {mv_i [ 2*`FMV_WIDTH-1],mv_i[ 2*`FMV_WIDTH-1:`FMV_WIDTH]}; 
assign   mvp_x = {mvp_i[   `FMV_WIDTH-1],mvp_i[  `FMV_WIDTH-1:         0]}; 
assign   mvp_y = {mvp_i[ 2*`FMV_WIDTH-1],mvp_i[2*`FMV_WIDTH-1:`FMV_WIDTH]}; 
assign   mv_x_diff_temp = mv_x - mvp_x ; 
assign   mv_y_diff_temp = mv_y - mvp_y ; 
assign   mv_x_diff      = {mv_x_diff_temp,1'b0}; 
assign   mv_y_diff      = {mv_y_diff_temp,1'b0}; 
always @* begin
    if(mv_x_diff[3])
        num_x_00    =    5'd7;
    else if(mv_x_diff[2])
        num_x_00    =    5'd5;
    else if(mv_x_diff[1])
        num_x_00    =    5'd3;
    else
        num_x_00    =    5'd1;
end
always @* begin
    if(mv_x_diff[7])
        num_x_01    =    5'd15;
    else if(mv_x_diff[6])
        num_x_01    =    5'd13;
    else if(mv_x_diff[5])
        num_x_01    =    5'd11;
    else if(mv_x_diff[4])
        num_x_01    =    5'd9;
    else
        num_x_01    =    5'd0;
end
always @* begin
    if(mv_x_diff[11])
        num_x_02    =    5'd31; 
    else if(mv_x_diff[10])
        num_x_02    =    5'd21;
    else if(mv_x_diff[9])
        num_x_02    =    5'd19;
    else if(mv_x_diff[8])
        num_x_02    =    5'd17;
    else
        num_x_02    =    5'd0;
end
always@*begin
    num_x  = num_x_00;
    if(num_x_02)
        num_x  = num_x_02;
    else if(num_x_01)
        num_x  = num_x_01;
    else if(num_x_00)
        num_x  = num_x_00;
end
always @* begin
    if(mv_y_diff[3])
        num_y_00    =    5'd7;
    else if(mv_y_diff[2])
        num_y_00    =    5'd5;
    else if(mv_y_diff[1])
        num_y_00    =    5'd3;
    else
        num_y_00    =    5'd1;
end
always @* begin
    if(mv_y_diff[7])
        num_y_01    =    5'd15;
    else if(mv_y_diff[6])
        num_y_01    =    5'd13;
    else if(mv_y_diff[5])
        num_y_01    =    5'd11;
    else if(mv_y_diff[4])
        num_y_01    =    5'd9;
    else
        num_y_01    =    5'd0;
end
always @* begin
    if(mv_y_diff[11])
        num_y_02    =    5'd31; 
    else if(mv_y_diff[10])
        num_y_02    =    5'd21;
    else if(mv_y_diff[9])
        num_y_02    =    5'd19;
    else if(mv_y_diff[8])
        num_y_02    =    5'd17;
    else
        num_y_02    =    5'd0;
end
always@*begin
    num_y  = num_y_00;
    if(num_y_02)
        num_y  = num_y_02;
    else if(num_y_01)
        num_y  = num_y_01;
    else if(num_y_00)
        num_y  = num_y_00;
end
assign mv_bits_cnt_o= num_x + num_y;
assign mvd_o   =  {mv_y_diff_temp,mv_x_diff_temp};
endmodule