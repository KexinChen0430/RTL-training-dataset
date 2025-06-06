module denise_playfields
(
  input  aga,                 
  input   [8:1] bpldata,      
  input   dblpf,              
  input [2:0] pf2of,          
  input  [6:0] bplcon2,       
  output  reg [2:1] nplayfield, 
  output  reg [7:0] plfdata   
);
wire pf2pri;                  
wire [2:0] pf2p;              
reg [7:0] pf2of_val;          
assign pf2pri = bplcon2[6];   
assign pf2p = bplcon2[5:3];   
always @ (*) begin
  case(pf2of)
    3'd0 : pf2of_val = 8'd0;
    3'd1 : pf2of_val = 8'd2;
    3'd2 : pf2of_val = 8'd4;
    3'd3 : pf2of_val = 8'd8;
    3'd4 : pf2of_val = 8'd16;
    3'd5 : pf2of_val = 8'd32;
    3'd6 : pf2of_val = 8'd64;
    3'd7 : pf2of_val = 8'd128;
  endcase
end
always @(*) begin
  if (dblpf) 
  begin
    nplayfield[1] = |bpldata[7:1:2]; 
    nplayfield[2] = |bpldata[8:2:2]; 
  end
  else 
  begin
    nplayfield[1] = 0; 
    nplayfield[2] = |bpldata[8:1]; 
  end
end
always @(*) begin
  if (dblpf) 
  begin
    if (pf2pri) 
    begin
      if (nplayfield[2]) 
      begin
        plfdata[7:0] = aga ? {4'b0000, bpldata[8:2:2]} + pf2of_val
                            : {4'b0000, 1'b1, bpldata[6:2:2]};
      end
      else if (nplayfield[1]) 
      begin
        plfdata[7:0] = {4'b0000, bpldata[7:1:2]};
      end
      else 
      begin
        plfdata[7:0] = 8'b00000000;
      end
    end
    else 
    begin
      if (nplayfield[1])
        plfdata[7:0] = {4'b0000, bpldata[7:1:2]};
      else if (nplayfield[2])
        plfdata[7:0] = aga ? {4'b0000, bpldata[8:2:2]} + pf2of_val
                            : {4'b0000, 1'b1, bpldata[6:2:2]};
      else
        plfdata[7:0] = 8'b00000000;
    end
  end
  else 
  begin
    if ((pf2p > 5) && bpldata[5] && !aga)
      plfdata[7:0] = {8'b00010000};
    else
      plfdata[7:0] = bpldata[8:1];
  end
end
endmodule 