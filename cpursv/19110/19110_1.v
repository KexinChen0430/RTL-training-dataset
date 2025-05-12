
module autoinst_multitemplate();

  input  Boo2;
  input  Boo3;
  input  a;
  input  b;
  wire [3:0] f4_dotnamed;

  SubB suba2(.a(a),.b(Boo2));
  SubB suba3(.a(Boo3),.b(b));
endmodule

