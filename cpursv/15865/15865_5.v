
module parameter_test;

  parameter  foo_size = 6*32;
  parameter  foo_lsb = 0;
  parameter  foo_msb = (foo_size+foo_lsb)+(0-1);
  parameter  temp0 = (3+1)+((1+1)+(5+4));
  parameter  temp1 = (3+1)+((1+1)+(5+((0-1)+4)));
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

