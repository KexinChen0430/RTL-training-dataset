module control(instr,
   aluop, ppp, ww,
   memop, maddr, wbyteen,
   regop, rrdaddra, rrdaddrb, rwraddrd,
   reginmuxop,
   aluinmuxop,
   immediate);
   input [0:31] instr;
   output [0:4] aluop, rrdaddra, rrdaddrb, rwraddrd;
   output [0:2] ppp, regop, memop;
   output [0:1] ww;
   output [0:20] maddr;
   output reginmuxop, aluinmuxop;
   output [0:15] wbyteen;
   output [0:31] immediate;
   reg [0:4] aluop, rrdaddra, rrdaddrb, rwraddrd;
   reg [0:2] ppp, regop, memop;
   reg [0:1] ww;
   reg [0:20] maddr;
   reg reginmuxop, aluinmuxop;
   reg [0:15] wbyteen;
   reg [0:31] immediate;
   parameter zero = 1'b0;
   parameter one = 1'b1;
   always @ (ppp or ww)
       begin
       if (ppp == `aa)
           wbyteen=16'b1111111111111111;
       else if (ppp == `uu)
           wbyteen=16'b1111111100000000;
       else if (ppp == `dd)
           wbyteen=16'b0000000011111111;
       else if (ppp == `ee)
           begin
           if (ww==`w8)
               wbyteen=16'b1010101010101010;
           if (ww==`w16)
               wbyteen=16'b1100110011001100;
           if (ww==`w32)
               wbyteen=16'b1111000011110000;
           end
        else if (ppp == `oo)
           begin
           if (ww==`w8)
               wbyteen=16'b0101010101010101;
           if (ww==`w16)
               wbyteen=16'b0011001100110011;
           if (ww==`w32)
               wbyteen=16'b0000111100001111;
           end
        else if (ppp == `mm)
           begin
           if (ww==`w8)
               wbyteen=16'b1000000000000000;
           if (ww==`w16)
               wbyteen=16'b1100000000000000;
           if (ww==`w32)
               wbyteen=16'b1111000000000000;
           end
        else if (ppp == `ll)
           begin
           if (ww==`w8)
               wbyteen=16'b0000000000000001;
           if (ww==`w16)
               wbyteen=16'b0000000000000011;
           if (ww==`w32)
               wbyteen=16'b0000000000001111;
           end
      end 
   always @ (instr)
       begin
       immediate={instr[16:20],{27{zero}}};
       ppp=instr[21:23];
       ww=instr[24:25];
       maddr=instr[11:31];
       rwraddrd=instr[6:10];
       rrdaddrb=instr[16:20];
       if (instr[2] == 1'b1) 
           begin
           aluop=instr[26:31]; 
           regop=`rd1wr1; 
           rrdaddra=instr[11:15]; 
           memop=`memnop; 
           aluinmuxop=one; 
           reginmuxop=zero; 
           end 
       else if (instr[3] == 1'b1) 
           begin
           if ({instr[26:28], instr[31]} == 4'b0101) 
               begin
               aluop={instr[26:30],zero}; 
               regop=`rd1wr1; 
               rrdaddra=instr[11:15]; 
               memop=`memnop; 
               aluinmuxop=one; 
               reginmuxop=zero; 
               end
           else if (instr[26:31]==6'b001000) 
               begin
               aluop=instr[26:31]; 
               regop=`rd1wr1; 
               rrdaddra=instr[11:15]; 
               memop=`memnop; 
               aluinmuxop=one; 
               reginmuxop=zero; 
               end
           else 
               begin
               aluop=instr[26:31]; 
               regop=`rd2wr1; 
               rrdaddra=instr[11:15]; 
               memop=`memnop;  
               aluinmuxop=zero; 
               reginmuxop=zero; 
               end
           end 
       else if (instr[4]==1'b1) 
           begin
           aluop=`alunop; 
           regop=`rd1wr0; 
           rrdaddra=instr[6:10]; 
           memop=`memwst;  
           aluinmuxop=zero; 
           reginmuxop=zero; 
           end 
       else if (instr[5]==1'b1) 
           begin
           aluop=`alunop; 
           regop=`rd0wr1; 
           rrdaddra=instr[11:15]; 
           memop=`memwld;  
           aluinmuxop=zero; 
           reginmuxop=one; 
           end 
       else 
           begin
           aluop=`alunop; 
           regop=`regnop; 
           rrdaddra=instr[11:15]; 
           memop=`memnop; 
           reginmuxop=zero; 
           aluinmuxop=zero; 
           end 
       end 
endmodule 