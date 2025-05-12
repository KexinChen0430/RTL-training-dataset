
module main;

  reg  [3:0] a,b;

  
  initial  
  begin
    a = 0;
    b = 0;
    for (a = 0; a < 4'd15; a = a+1)
        for (b = 0; b < 4'd15; b = b+1)
            $display("{a, b} == %b",{a,b});
  end
endmodule

