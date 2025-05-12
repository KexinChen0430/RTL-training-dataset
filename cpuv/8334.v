module epvl_chkr(clk, bpvl, bepvl, bdvl, stop);
    input clk;
    input bpvl;
    input bepvl;
    input bdvl;
    input stop;         
`ifdef JUST_COUNT_PACKETS
`else
    integer status;
`endif 
   always @(posedge clk) begin
      if (!bpvl && bepvl && bdvl) begin
         $display("%%E-%M, %0t BDVL cannot be deasserted with BEPVL",
                  $time);
         if (stop) begin
            #1000
`ifdef JUST_CHECK_COUNTS
`else
            status = $check_counts;
`endif 
            $display("%%I-%M, %0t Stopping simulation on error!", $time);
`ifdef BATCH
            $finish;
`else
            $stop;
`endif 
         end 
      end 
   end 
endmodule