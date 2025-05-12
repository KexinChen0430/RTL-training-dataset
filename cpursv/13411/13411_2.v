
module operation(Ain,Bin,addSubVals,andVals,notBVal,sub,computedValue,
                 overflow);

  parameter  width = 1;
  input  [(0-1)+width:0] Ain,Bin;
  input  addSubVals,andVals,notBVal,sub;
  output [(0-1)+width:0] computedValue;
  reg  [(0-1)+width:0] computedValue;
  output overflow;
  wire sign,lastNonSign;
  wire [(0-1)+width:0] holder;

  
  always @(*)
      begin
        case ({addSubVals,sub,andVals,notBVal})

          4'b1000: computedValue = Ain+Bin;

          4'b1100: computedValue = Ain-Bin;

          4'b0010: computedValue = Bin & Ain;

          4'b0001: computedValue = ~Bin;

          default: computedValue = {width{1'bx}};

        endcase

      end
  assign overflow = addSubVals ? ((~lastNonSign | (~sign & lastNonSign)) & ((lastNonSign & (~sign | sign)) | sign)) : 1'b0;
  assign {lastNonSign,holder[width+(0-1<<1):0]} = addSubVals ? (((({(0-1)+width{sub}} & ~Bin[width+(0-1<<1):0]) | ((Bin[width+(0-1<<1):0] & ~Bin[width+(0-1<<1):0]) | (Bin[width+(0-1<<1):0] & ~{(0-1)+width{sub}})))+sub)+Ain[width+(0-1<<1):0]) : {lastNonSign,holder[width+(0-1<<1):0]};
  assign {sign,holder[(0-1)+width]} = addSubVals ? (Ain[(0-1)+width]+(lastNonSign+((Bin[(0-1)+width] & (~sub | sub)) ^ sub))) : {sign,computedValue[(0-1)+width]};
endmodule

