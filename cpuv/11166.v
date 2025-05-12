module outputs
  wire [31 : 0] r1__read, r2__read;
  wire RDY_r1__read, RDY_r1__write, RDY_r2__read, RDY_r2__write;
  reg [31 : 0] ehr_r;
  wire [31 : 0] ehr_r$D_IN;
  wire ehr_r$EN;
  wire CAN_FIRE_RL_ehr_do_stuff,
       CAN_FIRE_r1__write,
       CAN_FIRE_r2__write,
       WILL_FIRE_RL_ehr_do_stuff,
       WILL_FIRE_r1__write,
       WILL_FIRE_r2__write;
  wire [31 : 0] x__h1056;
  assign RDY_r1__write = 1'd1 ;
  assign CAN_FIRE_r1__write = 1'd1 ;
  assign WILL_FIRE_r1__write = EN_r1__write ;
  assign r1__read = ehr_r ;
  assign RDY_r1__read = 1'd1 ;
  assign RDY_r2__write = 1'd1 ;
  assign CAN_FIRE_r2__write = 1'd1 ;
  assign WILL_FIRE_r2__write = EN_r2__write ;
  assign r2__read = EN_r1__write ? r1__write_1 : ehr_r ;
  assign RDY_r2__read = 1'd1 ;
  assign CAN_FIRE_RL_ehr_do_stuff = 1'd1 ;
  assign WILL_FIRE_RL_ehr_do_stuff = 1'd1 ;
  assign ehr_r$D_IN = EN_r2__write ? r2__write_1 : x__h1056 ;
  assign ehr_r$EN = 1'd1 ;
  assign x__h1056 = r2__read ;
  always@(posedge CLK)
  begin
    if (!RST_N)
      begin
        ehr_r <= `BSV_ASSIGNMENT_DELAY 32'd0;
      end
    else
      begin
        if (ehr_r$EN) ehr_r <= `BSV_ASSIGNMENT_DELAY ehr_r$D_IN;
      end
  end
  `ifdef BSV_NO_INITIAL_BLOCKS
  `else 
  initial
  begin
    ehr_r = 32'hAAAAAAAA;
  end
  `endif 
endmodule