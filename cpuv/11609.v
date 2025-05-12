module"); 
for (j=0;j<100;j=j+1) begin
    for (i=0;i<32;i=i+1) begin
        d = (32'h80000000 >> i);
        if(i < 31) d = d + ($random % (32'h40000000 >> i));
        #1 $display("%b -> %d", d, clz);
        if(i[4:0] != clz) begin
            $display("***** TEST FAILED *****");
            $display("Expected %d, got %d", i, clz);
            $finish;
        end
    end
end
d = 32'h00000000;
#1 $display("%b -> %d", d, clz);
if(5'd31 != clz) begin
    $display("***** TEST FAILED *****");
    $display("Expected 31, got %d", i, clz);
    $finish;
end
$display("***** TEST PASSED *****");
$finish;
end
endmodule