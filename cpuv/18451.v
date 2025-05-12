module here? 
mixfeedback <= 1'b0; 
X0 <= X0 ^ ramout[511:0]; 
X1 <= X1 ^ ramout[1023:512]; 
`endif 
end 
if (mcount==2 || mcount==10) 
mixfeedback <= 1; 
if (mcount == 9 || mcount == 17) 
begin 
mixfeedback <= 1'b0; 
X0 <= X1; 
X1 <= Xmix; 
end 
if (mcount == 17) 
begin 
mcount <= 0; 
cycle <= cycle + 11'd1; 
if (cycle == 1023) 
begin 
MixOut <= { Xmix, X1 }; 
Set_SMixOutRdy <= 1'b1; 
nonce_2 <= nonce_1; 
mstate <= R_IDLE; 
end 
end 
end 
`ifdef HALFRAM 
R_INT: begin 
mcount <= mcount + 6'd1; 
if (mcount==2 || mcount==10) 
mixfeedback <= 1'b1; 
if (mcount == 8) 
begin 
mixfeedback <= 0; 
X0 <= X1; 
X1 <= Xmix; 
end 
if (mcount == 16) 
begin 
mixfeedback <= 0; 
X0 <= X1 ^ X0Save; 
X1 <= Xmix ^ X1Save; 
mcount <= 2; 
mstate <= R_MIX; 
end 
end 
`endif 
endcase 
end 
`ifdef SIM 
if (mstate == R_MIX && mcount == 17) 
$display ("cycle %d Xmix %08x\n", cycle, Xmix[511:480]); 
`endif 
end 
endmodule 