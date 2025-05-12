module top (
   a, b
   );
   input                a;                      
   input                b;                      
   wire unused_pin;
   assign unused_pin = |{
                         1'b0} ;
   foo uut1 (
             a,
             b),
     uut2 (
           .a (a),
           .b (b));
   foo uut3 (
             .a                         (a),
             .b                         (b))  ;
   foo #(3, 4)
   uut4 (
             .a                         (a),
             .b                         (b));
   foo #(.PAR_A (5),
         .PAR_B (6))
   uut5 (
         .a                         (a),
         .b                         (b));
   foo uut6 [10:0]();
   foo uut7 [1:0][10:0]();
   foo uut8 () ;
   function void func_foo(int a);
   endfunction : func_foo
endmodule