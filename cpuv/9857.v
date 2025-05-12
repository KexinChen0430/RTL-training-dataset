module gminstdecode
  (
   output instClassType instClass 
   ); 
   always_comb begin
      instClass.iFunc           = '0;
      instClass.isBool          = '0;
      instClass.sub.bool        = '0;
      instClass.sub2.sub3.bool  = '0;
      if (ldBitFromIo | stBitToIo) begin
         instClass.isBool          = 1'b1;
         instClass.iFunc           = IFUNC_BOOL;
         instClass.sub.bool        = 1'b1;
         instClass.sub2.sub3.bool  = 1'b1;
      end
   end
   always_comb begin
      instClass  = '{default:0};     
      if (ldBitFromIo | stBitToIo) begin
         instClass.isBool  = 1'b1;
         instClass.iFunc   = IFUNC_BOOL;
      end
   end
   always_comb begin
      instClass.iFunc   = IFUNC_ADD;  
      instClass.isBool  = '0;
      if (ldBitFromIo | stBitToIo) begin
         instClass.isBool  = 1'b1;
         instClass.iFunc   = IFUNC_BOOL;
      end
   end
   always_comb begin
      instClass.sub             = '0;
      instClass.sub2            = '0;
      instClass.sub3.sub4.bool  = '0;
      if (ldBitFromIo | stBitToIo) begin
         instClass.sub.bool        = 1'b1;
         instClass.sub2.sub3.bool  = 1'b1;
         instClass.sub3.sub4.bool  = 1'b1;
      end
   end
endmodule 