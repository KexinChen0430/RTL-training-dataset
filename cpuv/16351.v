module arr;
   parameter LENGTH = 1;
   reg [LENGTH-1:0] sig ;
   reg [LENGTH-1:0] rfr ;
   reg check ;
   reg verbose ;
   always @(posedge check) begin
     if (verbose) $display("%m : %x %x", sig, rfr);
     if (check && sig != rfr) $stop;
     check <= 0;
   end
endmodule