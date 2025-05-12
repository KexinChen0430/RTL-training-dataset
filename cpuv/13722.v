module outputs 
assign A = A_reg; 
assign B = B_reg; 
assign C = C_reg; 
always @ (posedge clock) 
  begin
    if (reset) 
      begin
      GPR0_reg = 32'h00000000; GPR1_reg = 32'h00000000;
      GPR2_reg = 32'h00000000; GPR3_reg = 32'h00000000;
      GPR4_reg = 32'h00000000; GPR5_reg = 32'h00000000;
      GPR6_reg = 32'h00000000; GPR7_reg = 32'h00000000;
      GPR8_reg = 32'h00000000; GPR9_reg = 32'h00000000;
      GPRA_reg = 32'h00000000; GPRB_reg = 32'h00000000;
      GPRC_reg = 32'h00000000; GPRD_reg = 32'h00000000;
      GPRE_reg = 32'h00000000; GPRF_reg = 32'h00000000;
      A_reg = 32'h00000000;
      B_reg = 32'h00000000;
      C_reg = 32'h00000000;
      end
    else 
      begin
      GPR0_reg = regIn0; GPR1_reg = regIn1;
      GPR2_reg = regIn2; GPR3_reg = regIn3;
      GPR4_reg = regIn4; GPR5_reg = regIn5;
      GPR6_reg = regIn6; GPR7_reg = regIn7;
      GPR8_reg = regIn8; GPR9_reg = regIn9;
      GPRA_reg = regInA; GPRB_reg = regInB;
      GPRC_reg = regInC; GPRD_reg = regInD;
      GPRE_reg = regInE; GPRF_reg = regInF;
      A_reg = Data_A;
      B_reg = Data_B;
      C_reg = Data_C;
      end
  end
function [31:0] Select16;
  input [3:0]  sel; 
  input [31:0] d0,d1,d2,d3,d4,d5,d6,d7; 
  input [31:0] d8,d9,da,db,dc,dd,de,df; 
  case(sel) 
    4'h0: Select16=d0;
    4'h1: Select16=d1;
    4'h2: Select16=d2;
    4'h3: Select16=d3;
    4'h4: Select16=d4;
    4'h5: Select16=d5;
    4'h6: Select16=d6;
    4'h7: Select16=d7;
    4'h8: Select16=d8;
    4'h9: Select16=d9;
    4'hA: Select16=da;
    4'hB: Select16=db;
    4'hC: Select16=dc;
    4'hD: Select16=dd;
    4'hE: Select16=de;
    4'hF: Select16=df;
  endcase
endfunction
function [31:0] GPRdecode;
  input [3:0] xaddr; 
  input       xenb;  
  input [3:0] yaddr; 
  input       yenb;  
  input [31:0] x;    
  input [31:0] y;    
  input [31:0] hold; 
  input [3:0] gpr;   
  if ( (xaddr[3:0] == gpr[3:0]) && (xenb == 1'b1) )
     GPRdecode = x;
  else if ( (yaddr[3:0] == gpr[3:0]) && (yenb == 1'b1) )
     GPRdecode = y;
  else
     GPRdecode = hold;
endfunction
endmodule 