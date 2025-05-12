
module operation(Ain,Bin,addSubVals,andVals,notBVal,sub,computedValue,
                 overflow);

  parameter  width = 1;
  input  [width+(0-1):0] Ain,Bin;
  input  addSubVals,andVals,notBVal,sub;
  output [width+(0-1):0] computedValue;
  reg  [width+(0-1):0] computedValue;
  output overflow;
  wire sign,lastNonSign;
  wire [width+(0-1):0] holder;

  
  always @(*)
      begin
        case ({addSubVals,sub,andVals,notBVal})

          4'b1000: computedValue = Bin+Ain;

          4'b1100: computedValue = Ain-Bin;

          4'b0010: computedValue = Ain & Bin;

          4'b0001: computedValue = ~Bin;

          default: computedValue = {width{1'bx}};

        endcase

      end
  assign overflow = addSubVals ? ((((~lastNonSign & ((((lastNonSign & sign) ^ lastNonSign) & ~sign) | sign)) & sign) | (~sign & sign)) ^ ((lastNonSign & sign) ^ lastNonSign)) : 1'b0;
  assign {lastNonSign,holder[width-1<<1:0]} = addSubVals ? (sub+(((~Bin[width-1<<1:0] & {width+(0-1){sub}}) | (Bin[width-1<<1:0] & ~{width+(0-1){sub}}))+Ain[width-1<<1:0])) : {lastNonSign,holder[width-1<<1:0]};
  assign {sign,holder[width+(0-1)]} = addSubVals ? (((Bin[width+(0-1)] ^ ((Bin[width+(0-1)] | ~Bin[width+(0-1)]) & (((~Bin[width+(0-1)] & ((Bin[width+(0-1)] | ~Bin[width+(0-1)]) & ((Bin[width+(0-1)] & ~sub) | sub))) & sub) | (Bin[width+(0-1)] & sub))))+Ain[width+(0-1)])+lastNonSign) : {sign,computedValue[width+(0-1)]};
endmodule

