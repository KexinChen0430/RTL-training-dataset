module name
    nCs <= 1; 
    mosi <= 0; 
    sclk <= 0; 
    t = 16'd0; 
    repeat (33) begin 
        analog[(t - 1) * 16 +: 16] <= t; 
        #1; 
        t = t + 16'd1; 
        #1; 
    end 
end 
always begin 
    $display("#--- STARTING ---# Testbench for Intan RHD2000 Data Model..."); 
    #`STARTDELAY; 
    testConvert; 
    testCalibration; 
    testReadWrite; 
    $display("#--- FINISHED ---# RHD2000 Data Model."); 
    $finish; 
end 
endmodule 