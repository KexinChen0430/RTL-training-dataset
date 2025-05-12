module t (
   clk
   );
   input clk;
   integer cyc = 0;
   real  vin[0:1] ;
   wreal vout[0:1] ;
   swap  i_swap(.in0(vin[0]), .in1(vin[1]), .out0(vout[0]), .out1(vout[1]));
   always @ (posedge clk) begin
      cyc <= cyc + 1;
      if (cyc==0) begin
         vin[0] = 1.0;
         vin[1] = 2.0;
      end
      else if (cyc==2) begin
         vin[0] = 3.0;
         vin[1] = 4.0;
      end
      else if (cyc==3) begin
         if (vout[0] == vin[1] && vout[1] == vin[0]) begin
            $write("*-* All Finished *-*\n");
            $finish;
         end else begin
            $write("Mismatch %f %f\n", vout[0], vout[1]);
            $stop;
         end
      end
   end
endmodule