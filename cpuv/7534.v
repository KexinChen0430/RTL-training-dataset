module "FullAdderViaHAs"
wire [3:0] S;
wire c;
reg cin = 0;
wire [15:0] cinTVals;
reg [3:0] X1 = 0;
reg [3:0] X2 = 0;
wire RippleCarry4Bit0_0_c_FA0FA1;
wire RippleCarry4Bit0_0_FullAdder1_0_1_c;
wire RippleCarry4Bit0_0_FullAdder2_0_c;
wire [3:0] X1TVals [0:16-1];
wire [3:0] X2TVals [0:16-1];
wire RippleCarry4Bit0_0_S_i [0:4-1];
assign cinTVals = 16'd24636;
always @(c, X1, cin, X2, S) begin: RIPPLECARRY4BIT_TBV_PRINT_DATA
    $write("%h", X1);
    $write(" ");
    $write("%h", X2);
    $write(" ");
    $write("%h", cin);
    $write(" ");
    $write("%h", S);
    $write(" ");
    $write("%h", c);
    $write("\n");
end
assign RippleCarry4Bit0_0_S_i[0] = ((X1[0] ^ X2[0]) ^ cin);
assign RippleCarry4Bit0_0_c_FA0FA1 = (((X1[0] & X2[0]) | (X1[0] & cin)) | (X2[0] & cin));
assign RippleCarry4Bit0_0_S_i[1] = ((X1[1] ^ X2[1]) ^ RippleCarry4Bit0_0_c_FA0FA1);
assign RippleCarry4Bit0_0_FullAdder1_0_1_c = (((X1[1] & X2[1]) | (X1[1] & RippleCarry4Bit0_0_c_FA0FA1)) | (X2[1] & RippleCarry4Bit0_0_c_FA0FA1));
assign RippleCarry4Bit0_0_S_i[2] = ((X1[2] ^ X2[2]) ^ RippleCarry4Bit0_0_FullAdder1_0_1_c);
assign RippleCarry4Bit0_0_FullAdder2_0_c = (((X1[2] & X2[2]) | (X1[2] & RippleCarry4Bit0_0_FullAdder1_0_1_c)) | (X2[2] & RippleCarry4Bit0_0_FullAdder1_0_1_c));
assign RippleCarry4Bit0_0_S_i[3] = ((X1[3] ^ X2[3]) ^ RippleCarry4Bit0_0_FullAdder2_0_c);
assign c = (((X1[3] & X2[3]) | (X1[3] & RippleCarry4Bit0_0_FullAdder2_0_c)) | (X2[3] & RippleCarry4Bit0_0_FullAdder2_0_c));
assign S = {RippleCarry4Bit0_0_S_i[3], RippleCarry4Bit0_0_S_i[2], RippleCarry4Bit0_0_S_i[1], RippleCarry4Bit0_0_S_i[0]};
initial begin: RIPPLECARRY4BIT_TBV_STIMULES
    integer i;
    for (i=0; i<16; i=i+1) begin
        X1 <= X1TVals[i];
        X2 <= X2TVals[i];
        cin <= cinTVals[i];
        # 1;
    end
    $finish;
end
endmodule