module t (
   clk
   );
   input clk;
   integer cyc; initial cyc=1;
   reg [31:0] runner;  initial runner = 5;
   reg [31:0] runnerm1;
   reg [59:0] runnerq;
   reg [89:0] runnerw;
   always @ (posedge clk) begin
      if (cyc!=0) begin
         cyc <= cyc + 1;
         if (cyc==1) begin
`ifdef verilator
            if (runner != 0) $stop;  
`endif
         end
         if (cyc==2) begin
            runner = 20;
            runnerq = 60'h0;
            runnerw = 90'h0;
         end
         if (cyc==3) begin
            if (runner != 0) $stop;
            $write("*-* All Finished *-*\n");
            $finish;
         end
      end
   end
   always @ (runner) begin
      runnerm1 = runner - 32'd1;
   end
   always @ (runnerm1) begin
      if (runner > 0) begin
         runner = runnerm1;
         runnerq = runnerq - 60'd1;
         runnerw = runnerw - 90'd1;
         $write ("[%0t] runner=%d\n", $time, runner);
      end
   end
endmodule