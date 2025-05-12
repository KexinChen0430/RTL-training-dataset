
module parameter_test;

  parameter  foo_size = 32*6;
  parameter  foo_lsb = 0;
  parameter  foo_msb = (foo_size+foo_lsb)+(0-1);
  parameter  temp0 = ((1+1)+(3+4))+(1+5);
  parameter  temp1 = (4+(0-1))+((((1+3)+1)+5)+1);
  reg  [foo_msb:foo_lsb] foo;
  integer i;

  
  initial  
  begin
    for (i = 0; i < foo_size; i = 1+i)
        begin
          foo[i] = 1;
        end
    $write("foo = %0h\n",foo);
    $finish;
  end
endmodule

