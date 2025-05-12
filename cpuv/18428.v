module cast_real();
    int i;
    logic [3:0] l;
    logic signed [3:0] sl;
    real a, b, c, d, e;
    initial begin
        i = 5;
        a = real'(i);
        l = 4'b1010;
        b = real'(l);
        sl = 4'b1010;
        c = real'(sl);
        d = real'(11);
        e = real'(-7);
        if (a != 5.0)
        begin
            $display("FAILED #1 a = %f", a);
            $finish(); 
        end
        if (b != 10.0)
        begin
            $display("FAILED #2 b = %f", b);
            $finish(); 
        end
        if (c != -6.0)
        begin
            $display("FAILED #3 c = %f", c);
            $finish(); 
        end
        if (d != 11.0)
        begin
            $display("FAILED #4 d = %f", d);
            $finish(); 
        end
        if (e != -7.0)
        begin
            $display("FAILED #5 e = %f", e);
            $finish(); 
        end
        $display("PASSED");
    end
endmodule