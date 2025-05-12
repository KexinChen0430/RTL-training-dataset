module DivBug ;
    integer     intX, intY;
    initial
    begin
        intX = -8;
        intY = intX / 8;
        $display("%5d %5d", intX, intY);
    end
endmodule