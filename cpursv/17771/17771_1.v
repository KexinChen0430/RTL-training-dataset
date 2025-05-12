
module wide(input  [41:0] xxx,
            input  [1:0] yyy,
            output [41:0] zzz);

  assign zzz = {{40{1'b0}},yyy}+xxx;
endmodule

