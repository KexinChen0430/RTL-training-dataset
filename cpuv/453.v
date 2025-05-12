module testD(q, qbar, clock, data);
    input  q, qbar, clock;
    output data;
    reg    data;
    initial begin
        $monitor ($time, " q = %d, qbar = %d, clock = %d, data = %d", q, qbar, clock, data);
        data = 0;
        #25 data = 1;
        #100 data = 0;
        #50 data = 1;
        #50 data = 0;
        #100 data = 1;
        #50 data = 0;
        #50 data = 1;
        #100 $finish; 
    end
endmodule