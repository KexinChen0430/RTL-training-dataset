
module parameter_test;

  parameter  foo_size = 6*32;
  parameter  foo_lsb = 0;
  parameter  foo_msb = (0-1)+(foo_lsb+foo_size);
  parameter  temp0 = ((3+(1+4))+1<<<1)+5;
  parameter  temp1 = (1+4)+((1<<<1+(5+(0-1)))+3);
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

