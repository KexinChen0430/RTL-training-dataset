module stratixiigx_mac_out_add_sub_acc_unit( 
                                          dataa, 
                                          datab, 
                                          datac, 
                                          datad, 
                                          signa, 
                                          signb, 
                                          operation, 
                                          addnsub, 
                                          dataout, 
                                          overflow 
                                          );
parameter    dataa_width = 36; 
parameter    datab_width = 36; 
parameter    datac_width = 36; 
parameter    datad_width = 36; 
parameter   accuma_width = datab_width + 16; 
parameter   accumc_width = datad_width + 16; 
parameter   block_type  = "R"; 
input [71 : 0 ]  dataa; 
input [71 : 0 ]datab; 
input [71 :0]  datac; 
input [71:0]datad; 
input signa; 
input signb; 
input [3:0]      operation; 
input    addnsub; 
output [71 :0] dataout; 
output   overflow; 
reg[71:0] dataout_tmp; 
reg overflow_tmp; 
reg sign_a; 
reg sign_b; 
reg [71 :0] abs_a; 
reg [71 :0 ] abs_b; 
reg [71:0] datac_s; 
reg [71:0] datad_s; 
assign dataout = dataout_tmp; 
assign overflow = overflow_tmp; 
always @(dataa or datab or datac or datad or signa or signb or operation or addnsub) 
    begin
        if(operation == 4'b0111) 
            begin
                datac_s = signa ? {{(18){datac[35]}}, datac[35:0]} : {{18'b0, datac[35:0]}}; 
                datad_s = signb ? {{(18){datad[35]}}, datad[35:0]} : {{18'b0, datad[35:0]}}; 
                dataout_tmp = ({datab[35:0],36'b0}) + ({datac_s,18'b0}) + ({datad_s,18'b0}) + ({36'b0,dataa[35:0]}); 
                overflow_tmp = 1'b0; 
            end
        else if ((block_type == "R") &&(operation[2])) 
            begin
                sign_a  = (signa && dataa[accuma_width -1]); 
                abs_a = (sign_a) ? (~dataa[accuma_width -1 :0] + 1'b1) : dataa[accuma_width -1 :0]; 
                sign_b  = (signb && datab[datab_width-1]); 
                abs_b = (sign_b) ? (~datab[datab_width -1 :0] + 1'b1) : datab[datab_width -1 :0]; 
                if (addnsub == 1'b0) 
                    dataout_tmp = (sign_a ? -abs_a[accuma_width -1 :0] : abs_a[accuma_width -1 :0]) - (sign_b ? -abs_b[datab_width -1 :0] : abs_b[datab_width -1 :0]);
                else 
                    dataout_tmp = (sign_a ? -abs_a[accuma_width -1 :0] : abs_a[accuma_width -1 :0]) + (sign_b ? -abs_b[datab_width -1 :0] : abs_b[datab_width -1 :0]);
                if(signa || signb) 
                   overflow_tmp = dataout_tmp[accuma_width] ^ dataout_tmp[accuma_width -1];
                else 
                   overflow_tmp = dataout_tmp[accuma_width];
            end
        else if ((block_type == "S") &&(operation[2])) 
            begin
                sign_a  = (signa && datac[accumc_width -1]); 
                abs_a = (sign_a) ? (~datac[accumc_width -1 :0] + 1'b1) : datac[accumc_width -1 :0]; 
                sign_b  = (signb && datad[datad_width-1]); 
                abs_b = (sign_b) ? (~datad[datad_width -1 :0] + 1'b1) : datad[datad_width -1 :0]; 
                if (addnsub == 1'b0) 
                    dataout_tmp = (sign_a ? -abs_a[accumc_width -1 :0] : abs_a[accumc_width -1 :0]) - (sign_b ? -abs_b[datad_width -1 :0] : abs_b[datad_width -1 :0]);
                else 
                    dataout_tmp = (sign_a ? -abs_a[accumc_width -1 :0] : abs_a[accumc_width -1 :0]) + (sign_b ? -abs_b[datad_width -1 :0] : abs_b[datab_width -1 :0]);
                if(signa || signb) 
                    overflow_tmp = dataout_tmp[accumc_width] ^ dataout_tmp[accumc_width -1];
                else 
                    overflow_tmp = dataout_tmp[accumc_width];
            end
        else if(block_type == "T") 
            begin
                sign_a  = ( signa && dataa[dataa_width]); 
                sign_b  = ( signb && datab[datab_width]); 
                abs_a = ( sign_a ) ? (~dataa[dataa_width:0] + 1'b1) : dataa[dataa_width:0]; 
                abs_b = ( sign_b ) ? (~datab[datab_width:0] + 1'b1) : datab[datab_width:0]; 
                if (addnsub == 1'b0) 
                    dataout_tmp = (sign_a ? -abs_a[dataa_width:0]: abs_a[dataa_width:0]) - (sign_b ? -abs_b[datab_width:0] : abs_b[datab_width:0]);
                else 
                    dataout_tmp = (sign_a ? -abs_a[dataa_width:0]: abs_a[dataa_width:0]) + (sign_b ? -abs_b[datab_width:0] : abs_b[datab_width:0]);
                overflow_tmp = 1'b0; 
            end
        else if (block_type == "S") 
            begin
                sign_a  = (signa && datac[datac_width -1]); 
                abs_a = (sign_a) ? (~datac[datac_width -1:0]+ 1'b1) : datac[datac_width -1:0]; 
                sign_b  = (signb && datad[datad_width-1]); 
                abs_b = (sign_b) ? (~datad[datad_width -1:0] + 1'b1) : datad[datad_width -1:0]; 
                if (addnsub == 1'b0) 
                    dataout_tmp = (sign_a ? -abs_a[datac_width -1:0] : abs_a[datac_width -1:0]) - (sign_b ? -abs_b[datad_width -1:0] : abs_b[datad_width -1:0]);
                else 
                    dataout_tmp = (sign_a ? -abs_a[datac_width -1:0] : abs_a[datac_width -1:0]) + (sign_b ? -abs_b[datad_width -1:0] : abs_b[datad_width -1:0]);
                if(signa || signb) 
                    overflow_tmp = dataout_tmp[datac_width + 1] ^ dataout_tmp[datac_width];
                else 
                    overflow_tmp = dataout_tmp[datac_width + 1];
            end
        else 
            begin
                sign_a  = (signa && dataa[dataa_width -1]); 
                abs_a = (sign_a) ? (~dataa[dataa_width -1:0]+ 1'b1) : dataa[dataa_width -1:0]; 
                sign_b  = (signb && datab[datab_width-1]); 
                abs_b = (sign_b) ? (~datab[datab_width -1:0] + 1'b1) : datab[datab_width -1:0]; 
                if (addnsub == 1'b0) 
                    dataout_tmp = (sign_a ? -abs_a[dataa_width -1:0] : abs_a[dataa_width -1:0]) - (sign_b ? -abs_b[datab_width -1:0] : abs_b[datab_width -1:0]);
                else 
                    dataout_tmp = (sign_a ? -abs_a[dataa_width -1:0] : abs_a[dataa_width -1:0]) + (sign_b ? -abs_b[datab_width -1:0] : abs_b[datab_width -1:0]);
                if(signa || signb) 
                    overflow_tmp = dataout_tmp[dataa_width + 1] ^ dataout_tmp[dataa_width];
                else 
                    overflow_tmp = dataout_tmp[dataa_width + 1];
            end
    end
endmodule