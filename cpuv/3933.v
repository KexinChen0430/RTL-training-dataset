module fpga_interconnect(datain, dataout);
    input  datain;      
    output dataout;     
    assign dataout = datain;
    specify
        (datain => dataout) = 0;
    endspecify
endmodule