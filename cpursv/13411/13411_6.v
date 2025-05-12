
module operation(Ain,Bin,addSubVals,andVals,notBVal,sub,computedValue,
                 overflow);

  parameter  width = 1;
  input  [width-1:0] Ain,Bin;
  input  addSubVals,andVals,notBVal,sub;
  output [width-1:0] computedValue;
  reg  [width-1:0] computedValue;
  output overflow;
  wire sign,lastNonSign;
  wire [width-1:0] holder;

  
  always @(*)
      begin
        case ({addSubVals,sub,andVals,notBVal})

          4'b1000: computedValue = Ain+Bin;

          4'b1100: computedValue = Ain+(0-Bin);

          4'b0010: computedValue = Ain & Bin;

          4'b0001: computedValue = ~Bin;

          default: computedValue = {width{1'bx}};

        endcase

      end
  assign overflow = addSubVals ? (((sign & (lastNonSign | ~lastNonSign)) & ((~sign | sign) | ((lastNonSign | sign) & ~sign))) ^ (lastNonSign & ((~sign | sign) | ((lastNonSign | sign) & ~sign)))) : 1'b0;
  assign {lastNonSign,holder[width+(-1<<<1):0]} = addSubVals ? (sub+((((~{width-1{sub}} & Bin[width+(-1<<<1):0]) | (({width-1{sub}} & ~Bin[width+(-1<<<1):0]) & ~{width-1{sub}})) | (~Bin[width+(-1<<<1):0] & (((~{width-1{sub}} & Bin[width+(-1<<<1):0]) | {width-1{sub}}) & (~Bin[width+(-1<<<1):0] | Bin[width+(-1<<<1):0]))))+Ain[width+(-1<<<1):0])) : {lastNonSign,holder[width+(-1<<<1):0]};
  assign {sign,holder[width-1]} = addSubVals ? ((((sub ^ ((Bin[width-1] & (~sub | sub)) & sub)) | (~sub & Bin[width-1]))+lastNonSign)+Ain[width-1]) : {sign,computedValue[width-1]};
endmodule

