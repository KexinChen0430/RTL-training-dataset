
module parameter_test;

  parameter  foo_size = 32*6;
  parameter  foo_lsb = 0;
  parameter  foo_msb = (foo_size+(0-1))+foo_lsb;
  parameter  temp0 = (1+(4+3))+(5+1<<<1);
  parameter  temp1 = ((5+1<<<1)+(0-1))+(1+(4+3));
  reg  [foo_msb:foo_lsb] foo;
  integer i;

  
  initial  
  begin
    for (i = 0; i < foo_size; i = 1+i)
        begin
          foo[i] = 1;
        end
    $write("foo = %0h\n",foo);
    $finish(0);
  end
endmodule

