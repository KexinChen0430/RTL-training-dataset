module cast (inp, res); 
    parameter signed [31:0] old_width = 4; 
    parameter signed [31:0] old_bin_pt = 1; 
    parameter signed [31:0] new_width = 4; 
    parameter signed [31:0] new_bin_pt = 1; 
    parameter signed [31:0] new_arith = `xlSigned; 
    input [old_width - 1 : 0] inp; 
    output [new_width - 1 : 0] res; 
    parameter signed [31:0] right_of_dp = new_bin_pt - old_bin_pt;
    wire [new_width-1:0] result;
    genvar i;
    assign res = result;
    generate
        for (i = 0; i<new_width;  i = i+1)
            begin:cast_loop 
                if ((i-right_of_dp) > old_width - 1)
                    begin:u0 
                        if (new_arith == `xlUnsigned)
                            begin:u1 
                                assign result[i] = 1'b0; 
                            end
                        if (new_arith == `xlSigned)
                            begin:u2 
                                assign result[i] = inp[old_width-1]; 
                            end
                    end
                else if ((i-right_of_dp) >= 0)
                    begin:u3 
                        assign result[i] = inp[i-right_of_dp]; 
                    end
                else
                    begin:u4 
                        assign result[i] = 1'b0; 
                    end
            end
    endgenerate 
endmodule 