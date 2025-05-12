module c (); 
   always @ (t.cyc) begin
      if (t.cyc == 4) $display("mod c has scope = %m");
      if (t.cyc == 4) $display("mod c has tag   = %0s", tag.scope);
   end
endmodule