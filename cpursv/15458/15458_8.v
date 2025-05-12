
module parameter_test;

  parameter  foo_size = 6*32;
  parameter  foo_lsb = 0;
  parameter  foo_msb = (foo_size+(0-1))+foo_lsb;
  parameter  temp0 = (5+(3+(4+1)))+(1+1);
  parameter  temp1 = ((5+(3+(4+1)))+(1+1))+(0-1);
  reg  [foo_msb:foo_lsb] foo;
  integer i;

  
  initial  
  begin
    for (i = 0; i < foo_size; i = i+1)
        begin
          foo[i] = 1;
        end
    $write("foo = %0h\n",foo);
    $finish(0);
  end
endmodule

