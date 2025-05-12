module t (
   clk
   );
   input clk;
   integer cyc; initial cyc=1;
   reg [15:0] m_din; 
   reg [15:0] v1;    
   reg [15:0] v2;    
   reg [15:0] v3;    
   integer nosplit;
   always @ (posedge clk) begin
      $write(" values %x %x %x\n", v1, v2, v3);
      nosplit = cyc;
      if (nosplit > 2) begin
          v1 <= 16'h0;     
          v1 <= m_din;     
          if (m_din == 16'h0) begin 
             v2 <= v1;     
             v3 <= v2;     
         end
      end
   end
   always @ (posedge clk) begin
      if (cyc!=0) begin
         cyc <= cyc + 1;
         if (cyc == 7) begin
            $write("*-* All Finished *-*\n");
            $finish; 
         end
      end
   end
endmodule