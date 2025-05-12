module crypt_cycle_salt(
    input [31:0] L,          
    input [31:0] R,          
    input [67:0] K,          
    output [67:0] Kout,      
    input CLK,               
    output [31:0] L_out,     
    output [31:0] R_out      
);
wire [31:0] Ltmp [14:0];    
wire [31:0] Rtmp [14:0];    
wire [67:0] Ktmp [14:0];    
crypt_shift_salt_1 crypt_shift_salt_instance1 (L, R, K, Ktmp[0], CLK, Ltmp[0], Rtmp[0]);
crypt_shift_salt_1 crypt_shift_salt_instance2 (Ltmp[0], Rtmp[0], Ktmp[0], Ktmp[1], CLK, Ltmp[1], Rtmp[1]);
crypt_shift_salt_2 crypt_shift_salt_instance3 (Ltmp[1], Rtmp[1], Ktmp[1], Ktmp[2], CLK, Ltmp[2], Rtmp[2]);
crypt_shift_salt_2 crypt_shift_salt_instance4 (Ltmp[2], Rtmp[2], Ktmp[2], Ktmp[3], CLK, Ltmp[3], Rtmp[3]);
crypt_shift_salt_2 crypt_shift_salt_instance5 (Ltmp[3], Rtmp[3], Ktmp[3], Ktmp[4], CLK, Ltmp[4], Rtmp[4]);
crypt_shift_salt_2 crypt_shift_salt_instance6 (Ltmp[4], Rtmp[4], Ktmp[4], Ktmp[5], CLK, Ltmp[5], Rtmp[5]);
crypt_shift_salt_2 crypt_shift_salt_instance7 (Ltmp[5], Rtmp[5], Ktmp[5], Ktmp[6], CLK, Ltmp[6], Rtmp[6]);
crypt_shift_salt_2 crypt_shift_salt_instance8 (Ltmp[6], Rtmp[6], Ktmp[6], Ktmp[7], CLK, Ltmp[7], Rtmp[7]);
crypt_shift_salt_1 crypt_shift_salt_instance9 (Ltmp[7], Rtmp[7], Ktmp[7], Ktmp[8], CLK, Ltmp[8], Rtmp[8]);
crypt_shift_salt_2 crypt_shift_salt_instance10(Ltmp[8], Rtmp[8], Ktmp[8], Ktmp[9], CLK, Ltmp[9], Rtmp[9]);
crypt_shift_salt_2 crypt_shift_salt_instance11(Ltmp[9], Rtmp[9], Ktmp[9], Ktmp[10], CLK, Ltmp[10], Rtmp[10]);
crypt_shift_salt_2 crypt_shift_salt_instance12(Ltmp[10], Rtmp[10], Ktmp[10], Ktmp[11], CLK, Ltmp[11], Rtmp[11]);
crypt_shift_salt_2 crypt_shift_salt_instance13(Ltmp[11], Rtmp[11], Ktmp[11], Ktmp[12], CLK, Ltmp[12], Rtmp[12]);
crypt_shift_salt_2 crypt_shift_salt_instance14(Ltmp[12], Rtmp[12], Ktmp[12], Ktmp[13], CLK, Ltmp[13], Rtmp[13]);
crypt_shift_salt_2 crypt_shift_salt_instance15(Ltmp[13], Rtmp[13], Ktmp[13], Ktmp[14], CLK, Ltmp[14], Rtmp[14]);
crypt_shift_salt_1 crypt_shift_salt_instance16(Ltmp[14], Rtmp[14], Ktmp[14], Kout, CLK, R_out, L_out);
endmodule