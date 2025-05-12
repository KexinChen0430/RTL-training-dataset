module mi_nios_cpu_oci_test_bench (
    dct_buffer,       
    dct_count,        
    test_ending,      
    test_has_ended    
)
;
input   [ 29: 0] dct_buffer;
input   [  3: 0] dct_count;
input            test_ending;
input            test_has_ended;
endmodule