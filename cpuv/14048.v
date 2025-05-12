module
  always @*  
  if(aluop)begin  
  case(funct[4:1])  
    4'd4 :  alucontrol=0;   
    4'd2 :  alucontrol=1;   
    4'd0 :  alucontrol=2;   
    4'd12:  alucontrol=3;   
    4'd10:  alucontrol=1;   
    default:alucontrol=2'bxx;  
  endcase
   flagw[1]=funct[0];        
   flagw[0] = funct[0] & (alucontrol == 0 | alucontrol == 1);     
  end
else begin          
   flagw=0;  
   alucontrol=0;  
 end
 assign pcs =((rd == 15) & regw) | branch ;        
 assign nowrite = (funct[4:1]==10);  
endmodule  