
module trng(input  clk,
            input  en,
            output [7:0] R);

  wire [7:0] a,c;
  reg  [7:0] b,d;

  assign a = en ? (((~(~8'h80 & {a[0],a[7:1]}) & ~8'h80) & (({a[6:0],a[7]} & ((~a & ({a[6:0],a[7]} & ((a & (a | {a[6:0],a[7]})) | (~a & (a | {a[6:0],a[7]}))))) | ~{a[6:0],a[7]})) | (a & ~{a[6:0],a[7]}))) | ((({a[0],a[7:1]} & ~((((a | ~a) & ((a | {a[6:0],a[7]}) & ~8'h80)) & (~a & ({a[6:0],a[7]} & ((a & (a | {a[6:0],a[7]})) | (~a & (a | {a[6:0],a[7]})))))) | (((a | ~a) & ((a | {a[6:0],a[7]}) & ~8'h80)) & ~{a[6:0],a[7]}))) & ~8'h80) | ((~((~(({a[6:0],a[7]} & ((~a & ({a[6:0],a[7]} & ((a & (a | {a[6:0],a[7]})) | (~a & (a | {a[6:0],a[7]}))))) | ~{a[6:0],a[7]})) | (a & ~{a[6:0],a[7]})) & {a[0],a[7:1]}) | ((a & ~{a[0],a[7:1]}) ^ (~{a[0],a[7:1]} & {a[6:0],a[7]}))) & ((~8'h80 & ((((a & ~{a[0],a[7:1]}) ^ (~{a[0],a[7:1]} & {a[6:0],a[7]})) & {a[0],a[7:1]}) | (~(({a[6:0],a[7]} & ((~a & ({a[6:0],a[7]} & ((a & (a | {a[6:0],a[7]})) | (~a & (a | {a[6:0],a[7]}))))) | ~{a[6:0],a[7]})) | (a & ~{a[6:0],a[7]})) & {a[0],a[7:1]}))) | (((((a & ~{a[0],a[7:1]}) & ~(~{a[0],a[7:1]} & {a[6:0],a[7]})) & ~8'h80) | ~((~(({a[6:0],a[7]} & ((~a & ({a[6:0],a[7]} & ((a & (a | {a[6:0],a[7]})) | (~a & (a | {a[6:0],a[7]}))))) | ~{a[6:0],a[7]})) | (a & ~{a[6:0],a[7]})) & {a[0],a[7:1]}) | ((a & ~{a[0],a[7:1]}) ^ (~{a[0],a[7:1]} & {a[6:0],a[7]})))) | (((~{a[0],a[7:1]} & ~(a & ~{a[0],a[7:1]})) & ~8'h80) & {a[6:0],a[7]})))) & 8'h80))) : a;
  
  always @(posedge clk)  begin
    b <= a;
  end
  assign c = (((~b & {1'b0,d[7:1]}) & ~((~(d & 8'h96) | ~{d[6:0],1'b0}) & ((8'h96 | (((~(d & 8'h96) | ~{d[6:0],1'b0}) & ~(d & 8'h96)) & {d[6:0],1'b0})) & (~b & (d | (((~(d & 8'h96) | ~{d[6:0],1'b0}) & ~(d & 8'h96)) & {d[6:0],1'b0})))))) | ((b & ~b) | (~(((d & ~{1'b0,d[7:1]}) & (8'h96 & ~{d[6:0],1'b0})) | (((~(d & 8'h96) | ~{d[6:0],1'b0}) & ({d[6:0],1'b0} & ~{1'b0,d[7:1]})) | ({1'b0,d[7:1]} & (((((d & ~{1'b0,d[7:1]}) & (8'h96 & ~{d[6:0],1'b0})) | ~((((~{d[6:0],1'b0} | {d[6:0],1'b0}) & {d[6:0],1'b0}) | ((d & 8'h96) & (~{d[6:0],1'b0} | {d[6:0],1'b0}))) & (~(d & 8'h96) | ~{d[6:0],1'b0}))) | ((~(d & 8'h96) | ~{d[6:0],1'b0}) & ({d[6:0],1'b0} & ~{1'b0,d[7:1]}))) & ~((((~{d[6:0],1'b0} | {d[6:0],1'b0}) & {d[6:0],1'b0}) | ((d & 8'h96) & (~{d[6:0],1'b0} | {d[6:0],1'b0}))) & (~(d & 8'h96) | ~{d[6:0],1'b0})))))) & b))) | ((((~(~b & {1'b0,d[7:1]}) & ~b) & (~(d & 8'h96) | ~{d[6:0],1'b0})) & {d[6:0],1'b0}) | (((8'h96 & ~{d[6:0],1'b0}) & ((~(d & 8'h96) | ~{d[6:0],1'b0}) & d)) & ((~(~b & {1'b0,d[7:1]}) & ~b) & (~(d & 8'h96) | ~{d[6:0],1'b0}))));
  
  always @(posedge clk)
      begin
        d <= en ? c : d;
      end
  assign R = d;
endmodule

