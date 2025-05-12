module arriaii_second_stage_add_accum(
    dataa,
    datab,
    accumin,
    sign,
    operation,
    dataout,
    overflow
   );
parameter dataa_width = 36; 
parameter datab_width = 36; 
parameter accum_width = dataa_width + 8; 
parameter ssa_mode = "add"; 
input [71 : 0 ] dataa; 
input [71 : 0 ] datab; 
input [71 : 0] accumin; 
input sign; 
input [3:0] operation; 
output overflow; 
output [71 :0] dataout; 
reg [71 :0] dataout_tmp; 
reg [71:0] dataa_tmp; 
reg [71:0] datab_tmp; 
reg [71:0] accum_tmp; 
reg sign_a; 
reg sign_b; 
reg sign_accum; 
reg sign_out; 
reg overflow_tmp; 
reg [71 :0] abs_a; 
reg [71 :0] abs_b; 
reg [71 :0] abs_accum; 
specify
    (dataa *> dataout) = (0, 0); 
    (datab *> dataout) = (0, 0); 
    (sign *> dataout) = (0, 0); 
    (dataa *> overflow) = (0, 0); 
    (datab *> overflow) = (0, 0); 
    (sign *> overflow) = (0, 0); 
    if(operation == 4'b0011 || operation == 4'b0100 )
        (accumin *> dataout) = (0, 0); 
    if(operation == 4'b0011 || operation == 4'b0100 )
        (accumin *> overflow) = (0, 0); 
endspecify
assign dataout = dataout_tmp; 
assign overflow = overflow_tmp; 
always@(dataa or datab or sign or accumin or operation)
    begin
        sign_accum = (sign && accumin[accum_width -1]); 
        abs_accum = (sign_accum) ? (~accumin + 1'b1) : accumin; 
        sign_a = (sign && dataa[dataa_width-1]); 
        abs_a = (sign_a) ? (~dataa + 1'b1) : dataa; 
        sign_b = (sign && datab[datab_width-1]); 
        abs_b = (sign_b) ? (~datab + 1'b1) : datab; 
        if(operation == 4'b0011 || operation == 4'b0100 ) 
            begin
                if (ssa_mode == "add")
                    dataout_tmp = (sign_accum ? -abs_accum[accum_width -1 : 0] : abs_accum[accum_width -1 : 0]) + (sign_a ? -abs_a[accum_width -1 : 0] : abs_a[accum_width -1 : 0]) + (sign_b ? -abs_b[accum_width -1 : 0] : abs_b[accum_width -1 : 0]);
                else
                    dataout_tmp = (sign_accum ? -abs_accum[accum_width -1 : 0] : abs_accum[accum_width -1 : 0]) - (sign_a ? -abs_a[accum_width -1 : 0] : abs_a[accum_width -1 : 0]) - (sign_b ? -abs_b[accum_width -1 : 0] : abs_b[accum_width -1 : 0]);
                if(sign)
                    overflow_tmp = dataout_tmp[accum_width] ^ dataout_tmp[accum_width -1];
                else
                    begin
                        if(ssa_mode == "add")
                            overflow_tmp = dataout_tmp[accum_width];
                        else
                            overflow_tmp = 1'bX; 
                    end
            end
        else if( operation == 4'b0101 || operation == 4'b0110) 
            begin
                dataout_tmp = (sign_a ? -abs_a : abs_a) + (sign_b ?-abs_b : abs_b);
                overflow_tmp = 'b0; 
            end
        else if(( operation == 4'b0111) ||(operation == 4'b1000)) 
            begin
                dataout_tmp[71:0] = {dataa[53:0],18'b0} + datab;
                overflow_tmp = 'b0; 
            end
        else if(( operation == 4'b1001) ) 
            begin
                dataout_tmp[71:0] = dataa + datab;
                overflow_tmp = 'b0; 
            end
    end
endmodule 