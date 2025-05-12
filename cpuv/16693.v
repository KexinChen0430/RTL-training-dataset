module vhdl_multidim_array_test; 
vhdl_multidim_array dut(); 
initial begin 
    int i, j; 
    for(i = 0; i <= 1; i = i + 1) begin 
        for(j = dut.array_size - 1; j >= 0; j = j - 1) begin 
            $display("%d", dut.arr[i][j]); 
        end 
    end 
    $display("PASSED"); 
end 
endmodule 