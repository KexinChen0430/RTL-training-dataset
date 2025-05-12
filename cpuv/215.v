module encoder(in, out);
    input [39:0] in;
    output [5:0] out;
    assign out =  
        (in[0]  == 1'b1) ? 6'd0  : 
        (in[1]  == 1'b1) ? 6'd1  : 
        (in[2]  == 1'b1) ? 6'd2  : 
        (in[3]  == 1'b1) ? 6'd3  : 
        (in[4]  == 1'b1) ? 6'd4  : 
        (in[5]  == 1'b1) ? 6'd5  : 
        (in[6]  == 1'b1) ? 6'd6  : 
        (in[7]  == 1'b1) ? 6'd7  : 
        (in[8]  == 1'b1) ? 6'd8  : 
        (in[9]  == 1'b1) ? 6'd9  : 
        (in[38] == 1'b1) ? 6'd38 : 
        (in[39] == 1'b1) ? 6'd39 : 
        6'b000000;
endmodule