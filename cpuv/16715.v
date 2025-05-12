module ivl_sformatf_test;
wire test_net;
assign (pull1, strong0) test_net = 1'b1;
struct packed {
    logic [15:0] high;
    logic [15:0] low;
} word; 
initial begin
    string f; 
    word = 32'b0101_0101_0101_0101_0101_0101_0101_0101;
    f = $sformatf("sformatf test 1: %b %d %o %x", 8'd120, -12, 331, 120, 97);
    if(f != "sformatf test 1: 01111000         -12 00000000513 00000078         97") begin
        $display(f); 
        $display("FAILED 1"); 
        $finish(); 
    end
    f = $sformatf("sformatf test 2: %e %f %g", 123.45, 100e12, 100e12);
    if(f != "sformatf test 2: 1.234500e+02 100000000000000.000000 1e+14") begin
        $display(f); 
        $display("FAILED 2"); 
        $finish(); 
    end
    f = $sformatf("sformatf test 3: %s %c", "'string test'", 97);
    if(f != "sformatf test 3: 'string test' a") begin
        $display(f); 
        $display("FAILED 3"); 
        $finish(); 
    end
    f = $sformatf("sformatf test 4: %t %v %u %z", 120s, test_net, word, word);
    if(f != "sformatf test 4:                  120 Pu1 UUUU UUUU") begin
        $display(f); 
        $display("FAILED 4"); 
        $finish(); 
    end
    $display("PASSED"); 
end
endmodule 