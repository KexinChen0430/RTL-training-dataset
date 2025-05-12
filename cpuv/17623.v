module ripple_adder(a, b, cin, cout, sumout);
   parameter width = 0;
   input [width-1:0] a, b;
   input              cin;
   output [width-1:0] sumout;
   output             cout;
   specify
      (a=>sumout)="";
      (b=>sumout)="";
      (cin=>sumout)="";
      (a=>cout)="";
      (b=>cout)="";
      (cin=>cout)="";
   endspecify
   assign {cout, sumout} = a + b + cin;
endmodule