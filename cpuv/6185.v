module
    $monitor ("pc: %b, pr: %b, s: %b, data: %b", w_bus_addr, w_bus_pr_out, w_sr_out, w_bus_data);
    #2 r_reset = 1'b0;									
end
always #1 begin											
    r_clock = ~w_clock;									
    if (w_hlt) begin
        $display ("HLT call: Halting system.");
        $finish;									
    end
end
endmodule