
module quadrature_decoder(direction_o,count_pulse_o,error_o,clk,enable_i,reset_i,
                          quadA_i,quadB_i,quadA,quadA_old,quadB,quadB_old);

  output 
      direction_o  ,
      count_pulse_o,
      error_o      ,
      quadA        ,
      quadA_old    ,
      quadB        ,
      quadB_old    ;
  input  clk,enable_i,reset_i,quadA_i,quadB_i;
  wire clk_i,enable_i,reset_i,quadA_i,quadB_i;
  reg  direction_o,count_pulse_o,error_o;
  reg  quadA,quadA_old,quadB,quadB_old;

  
  always @(posedge clk)
      begin
        if (reset_i) 
          begin
            quadA_old <= 0;
            quadB_old <= 0;
            quadA <= 0;
            quadB <= 0;
            direction_o <= 0;
            count_pulse_o <= 0;
            error_o <= 0;
          end
          
        if (enable_i) 
          begin
            count_pulse_o <= ((((((~quadB_old & ~(~quadB_old & quadB)) & quadA_old) ^ ((~quadB_old & ~(~quadB_old & quadB)) & quadA)) | (quadB_old | ((~quadB_old & quadB) & ~((~quadB_old & (~quadA_old | (~quadA & quadA_old))) & (quadA | (~quadA & quadA_old)))))) & ((~((((((~quadB & (~(~quadB & quadA_old) & quadA)) | (~((~quadA & quadA_old) | (quadA & ~quadA_old)) | ((~quadB & quadA_old) & ~(~quadB & quadA)))) & (~quadB & quadA_old)) & ((~quadB & (~(~quadB & quadA_old) & quadA)) | (~((~quadA & quadA_old) | (quadA & ~quadA_old)) | ((~quadB & quadA_old) & ~(~quadB & quadA))))) ^ (((~quadB & quadA) & ((~quadB & (~(~quadB & quadA_old) & quadA)) | (~((~quadA & quadA_old) | (quadA & ~quadA_old)) | ((~quadB & quadA_old) & ~(~quadB & quadA))))) & ((~quadB & (~(~quadB & quadA_old) & quadA)) | (~((~quadA & quadA_old) | (quadA & ~quadA_old)) | ((~quadB & quadA_old) & ~(~quadB & quadA)))))) | (~((~quadA & quadA_old) | (quadA & ~quadA_old)) & ((quadB | ((~quadB & quadA_old) & ~quadA)) | (~quadB & (quadA & ~quadA_old))))) | ~quadB_old) & (((~((((((~quadB & (~(~quadB & quadA_old) & quadA)) | (~((~quadA & quadA_old) | (quadA & ~quadA_old)) | ((~quadB & quadA_old) & ~(~quadB & quadA)))) & (~quadB & quadA_old)) & ((~quadB & (~(~quadB & quadA_old) & quadA)) | (~((~quadA & quadA_old) | (quadA & ~quadA_old)) | ((~quadB & quadA_old) & ~(~quadB & quadA))))) ^ (((~quadB & quadA) & ((~quadB & (~(~quadB & quadA_old) & quadA)) | (~((~quadA & quadA_old) | (quadA & ~quadA_old)) | ((~quadB & quadA_old) & ~(~quadB & quadA))))) & ((~quadB & (~(~quadB & quadA_old) & quadA)) | (~((~quadA & quadA_old) | (quadA & ~quadA_old)) | ((~quadB & quadA_old) & ~(~quadB & quadA)))))) | (~((~quadA & quadA_old) | (quadA & ~quadA_old)) & ((quadB | ((~quadB & quadA_old) & ~quadA)) | (~quadB & (quadA & ~quadA_old))))) | ~quadB_old) & (~quadB_old & quadA_old)) ^ ((~((((((~quadB & (~(~quadB & quadA_old) & quadA)) | (~((~quadA & quadA_old) | (quadA & ~quadA_old)) | ((~quadB & quadA_old) & ~(~quadB & quadA)))) & (~quadB & quadA_old)) & ((~quadB & (~(~quadB & quadA_old) & quadA)) | (~((~quadA & quadA_old) | (quadA & ~quadA_old)) | ((~quadB & quadA_old) & ~(~quadB & quadA))))) ^ (((~quadB & quadA) & ((~quadB & (~(~quadB & quadA_old) & quadA)) | (~((~quadA & quadA_old) | (quadA & ~quadA_old)) | ((~quadB & quadA_old) & ~(~quadB & quadA))))) & ((~quadB & (~(~quadB & quadA_old) & quadA)) | (~((~quadA & quadA_old) | (quadA & ~quadA_old)) | ((~quadB & quadA_old) & ~(~quadB & quadA)))))) | (~((~quadA & quadA_old) | (quadA & ~quadA_old)) & ((quadB | ((~quadB & quadA_old) & ~quadA)) | (~quadB & (quadA & ~quadA_old))))) | ~quadB_old) & (~quadB_old & quadA))))) ^ (((((~quadB_old & ~(~quadB_old & quadB)) & quadA_old) ^ ((~quadB_old & ~(~quadB_old & quadB)) & quadA)) | (quadB_old | ((~quadB_old & quadB) & ~((~quadB_old & (~quadA_old | (~quadA & quadA_old))) & (quadA | (~quadA & quadA_old)))))) & (((~((((((~quadB & (~(~quadB & quadA_old) & quadA)) | (~((~quadA & quadA_old) | (quadA & ~quadA_old)) | ((~quadB & quadA_old) & ~(~quadB & quadA)))) & (~quadB & quadA_old)) & ((~quadB & (~(~quadB & quadA_old) & quadA)) | (~((~quadA & quadA_old) | (quadA & ~quadA_old)) | ((~quadB & quadA_old) & ~(~quadB & quadA))))) ^ (((~quadB & quadA) & ((~quadB & (~(~quadB & quadA_old) & quadA)) | (~((~quadA & quadA_old) | (quadA & ~quadA_old)) | ((~quadB & quadA_old) & ~(~quadB & quadA))))) & ((~quadB & (~(~quadB & quadA_old) & quadA)) | (~((~quadA & quadA_old) | (quadA & ~quadA_old)) | ((~quadB & quadA_old) & ~(~quadB & quadA)))))) | (~((~quadA & quadA_old) | (quadA & ~quadA_old)) & ((quadB | ((~quadB & quadA_old) & ~quadA)) | (~quadB & (quadA & ~quadA_old))))) | ~quadB_old) & (~quadB_old & quadB)) & (~((((((~quadB & (~(~quadB & quadA_old) & quadA)) | (~((~quadA & quadA_old) | (quadA & ~quadA_old)) | ((~quadB & quadA_old) & ~(~quadB & quadA)))) & (~quadB & quadA_old)) & ((~quadB & (~(~quadB & quadA_old) & quadA)) | (~((~quadA & quadA_old) | (quadA & ~quadA_old)) | ((~quadB & quadA_old) & ~(~quadB & quadA))))) ^ (((~quadB & quadA) & ((~quadB & (~(~quadB & quadA_old) & quadA)) | (~((~quadA & quadA_old) | (quadA & ~quadA_old)) | ((~quadB & quadA_old) & ~(~quadB & quadA))))) & ((~quadB & (~(~quadB & quadA_old) & quadA)) | (~((~quadA & quadA_old) | (quadA & ~quadA_old)) | ((~quadB & quadA_old) & ~(~quadB & quadA)))))) | (~((~quadA & quadA_old) | (quadA & ~quadA_old)) & ((quadB | ((~quadB & quadA_old) & ~quadA)) | (~quadB & (quadA & ~quadA_old))))) | ~quadB_old)))) | (quadB_old & ~((((((~quadB & (~(~quadB & quadA_old) & quadA)) | (~((~quadA & quadA_old) | (quadA & ~quadA_old)) | ((~quadB & quadA_old) & ~(~quadB & quadA)))) & (~quadB & quadA_old)) & ((~quadB & (~(~quadB & quadA_old) & quadA)) | (~((~quadA & quadA_old) | (quadA & ~quadA_old)) | ((~quadB & quadA_old) & ~(~quadB & quadA))))) ^ (((~quadB & quadA) & ((~quadB & (~(~quadB & quadA_old) & quadA)) | (~((~quadA & quadA_old) | (quadA & ~quadA_old)) | ((~quadB & quadA_old) & ~(~quadB & quadA))))) & ((~quadB & (~(~quadB & quadA_old) & quadA)) | (~((~quadA & quadA_old) | (quadA & ~quadA_old)) | ((~quadB & quadA_old) & ~(~quadB & quadA)))))) | (~((~quadA & quadA_old) | (quadA & ~quadA_old)) & ((quadB | ((~quadB & quadA_old) & ~quadA)) | (~quadB & (quadA & ~quadA_old))))));
            error_o <= 
((~quadA_old & (quadA_i | (quadA_old & ~quadA_i))) | (quadA_old & ~quadA_i)) && (quadB_i ^ quadB_old);
            direction_o <= (((quadA_old & quadB_old) & (!quadA_i & quadB_i)) | ((((quadA_i & !quadB_i) | ((quadA_i & (quadA_old & quadB_i)) & !quadB_old)) & (((quadA_i & (quadA_old & quadB_i)) & !quadB_old) | (!quadB_old & (!quadA_old & (!quadB_old | (quadA_i & (!quadB_i & !quadA_old))))))) | (!quadA_i & !quadB_i))) & (((quadB_old | (!quadB_old & ((((!quadB_old & (quadA_i & (!quadB_i & !quadA_old))) | (quadB_i & quadA_i)) & quadA_old) | ((!quadB_old & (quadA_i & (!quadB_i & !quadA_old))) | quadB_old)))) & !quadA_old) | (((!quadB_old & (quadA_i & !quadB_i)) | ((((quadA_old & quadB_old) & (!quadA_i & quadB_i)) | (quadB_i & quadA_i)) & ((!quadB_old & quadA_old) | ((quadA_old & quadB_old) & (!quadA_i & quadB_i))))) & ((((quadA_i & !quadB_i) | ((quadA_i & (quadA_old & quadB_i)) & !quadB_old)) & (((quadA_i & (quadA_old & quadB_i)) & !quadB_old) | (!quadB_old & (!quadA_old & (!quadB_old | (quadA_i & (!quadB_i & !quadA_old))))))) | (!quadA_old | ((quadA_old & quadB_old) & (!quadA_i & quadB_i))))));
            quadA_old <= quadA;
            quadB_old <= quadB;
            quadA <= quadA_i;
            quadB <= quadB_i;
          end
          
      end
endmodule

