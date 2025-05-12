module's undeclared outputs) 
   reg          CC; 
   reg [15:0]   regO; 
   reg [15:0]   regR; 
   reg      c; 
   reg [15:0]  add; 
   reg [33:0]  mul; 
   reg [31:0]  shl, 
                shr; 
   assign f_dto = regR; 
   assign g_dto = regR; 
   assign rwd = regR; 
   assign src = regA; 
   assign tgt = regB; 
   always @(opc or src or tgt) begin 
      {c,add} <= (~opc[0]) ? (src + tgt) : (src - tgt); 
      mul <= {1'b0,src} * {1'b0,tgt}; 
      shl <= src << tgt; 
      shr <= src >> tgt; 
   end
   always @(posedge clk) 
     if (rst) begin 
   CC <= 1'h0; 
   regO <= 16'h0; 
   regR <= 16'h0; 
     end else if (ena) begin 
   if (pha == 2'o0) 
     case (opc) 
       4'h2: regO <= {15'd0,c}; 
       4'h3: regO <= {(16){c}}; 
       4'h4: regO <= mul[31:16]; 
       4'h7: regO <= shl[31:16]; 
       4'h8: regO <= shr[15:0]; 
       default: regO <= regO; 
     endcase 
   if (pha == 2'o0) 
     case (opc) 
       4'h0: regR <= src; 
       4'h1: regR <= tgt; 
       4'h2: regR <= add; 
       4'h3: regR <= add; 
       4'h4: regR <= mul[15:0]; 
       4'h7: regR <= shl[15:0]; 
       4'h8: regR <= shr[31:16]; 
       4'h9: regR <= src & tgt; 
       4'hA: regR <= src | tgt; 
       4'hB: regR <= src ^ tgt; 
       default: regR <= 16'hX; 
     endcase 
   if (pha == 2'o0) 
     case (opc) 
     endcase 
   if (pha == 2'o0) 
     case (opc) 
       4'hC: CC <= (src == tgt); 
       4'hD: CC <= (src != tgt); 
       4'hE: CC <= (src > tgt); 
       4'hF: CC <= |(src & tgt); 
       default: CC <= 1'b1; 
     endcase 
     end
endmodule 