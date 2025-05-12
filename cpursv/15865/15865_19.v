
module parameter_test;

  parameter  foo_size = 32*6;
  parameter  foo_lsb = 0;
  parameter  foo_msb = (foo_size+foo_lsb)-1;
  parameter  temp0 = ((1+5)+(4+3))+1<<<1;
  parameter  temp1 = ((1+(-1))+1)+((1+5)+(4+3));
  reg  [foo_msb:foo_lsb] foo;
  integer i;

  
  initial  
  begin
    for (i = 0; i < foo_size; i = i+1)
        begin
          foo[i] = 1;
        end
    $write("foo = %0h\n",foo);
    $finish;
  end
endmodule

