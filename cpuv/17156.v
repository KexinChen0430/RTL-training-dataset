module vhdl_textio_write_test; 
reg write; 
vhdl_textio_write dut(write); 
initial begin 
    $display("PASSED"); 
end 
endmodule 