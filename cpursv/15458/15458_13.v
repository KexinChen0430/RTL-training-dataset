
module parameter_test;

  parameter  foo_size = 32*6;
  parameter  foo_lsb = 0;
  parameter  foo_msb = foo_size+(foo_lsb+(0-1));
  parameter  temp0 = (5+(1+4))+((1+3)+1);
  parameter  temp1 = (((1+5)+1)+(0-1))+((3+4)+1);
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

