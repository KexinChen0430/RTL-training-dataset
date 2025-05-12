module zero_detect_owire(in, out); 
  input [`WIDTH-1:0] in; 
  output out; 
  wor rez; 
  genvar g; 
  assign rez = in[0]; 
  generate 
    for(g = 1; g < `WIDTH; g = g+1) begin : adsf 
      assign rez = in[g]; 
    end 
  endgenerate
  assign out = ~rez; 
endmodule