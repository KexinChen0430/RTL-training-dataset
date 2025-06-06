
module joystick_protocols(input  wire clk,
                          input  wire [15:0] a,
                          input  wire iorq_n,
                          input  wire rd_n,
                          input  wire [7:0] din,
                          output reg [7:0] dout,
                          output reg oe_n,
                          input  wire [7:0] zxuno_addr,
                          input  wire zxuno_regrd,
                          input  wire zxuno_regwr,
                          input  wire [4:0] kbdjoy_in,
                          input  wire [4:0] db9joy_in,
                          input  wire [4:0] kbdcol_in,
                          output reg [4:0] kbdcol_out,
                          input  wire vertical_retrace_int_n);

  parameter 
       JOYCONFADDR    = 8'h06,
       KEMPSTONADDR   = 8'h1F,
       SINCLAIRP1ADDR = 12,
       SINCLAIRP2ADDR = 11,
       FULLERADDR     = 8'h7F,
       DISABLED       = 3'h0,
       KEMPSTON       = 3'h1,
       SINCLAIRP1     = 3'h2,
       SINCLAIRP2     = 3'h3,
       CURSOR         = 3'h4,
       FULLER         = 3'h5;
  reg   db9joyup = 1'b0;
  reg   db9joydown = 1'b0;
  reg   db9joyleft = 1'b0;
  reg   db9joyright = 1'b0;
  reg   db9joyfire = 1'b0;
  reg   kbdjoyup = 1'b0;
  reg   kbdjoydown = 1'b0;
  reg   kbdjoyleft = 1'b0;
  reg   kbdjoyright = 1'b0;
  reg   kbdjoyfire = 1'b0;

  
  always @(posedge clk)
      begin
        {db9joyfire,db9joyup,db9joydown,db9joyleft,db9joyright} <= ~db9joy_in;
        {kbdjoyfire,kbdjoyup,kbdjoydown,kbdjoyleft,kbdjoyright} <= kbdjoy_in;
      end
  reg  [7:0]  joyconf = {1'b0,SINCLAIRP1,1'b0,KEMPSTON};

  
  always @(posedge clk)
      begin
        if ((zxuno_addr == JOYCONFADDR) && (zxuno_regwr == 1'b1)) joyconf <= din;
          
      end
  reg  [2:0]  cont_autofire = 3'b000;

  reg  [3:0]  edge_detect = 4'b0000;

  wire  autofire = cont_autofire[2];

  
  always @(posedge clk)
      begin
        edge_detect <= {edge_detect[2:0],vertical_retrace_int_n};
        if (edge_detect == 4'b0011) cont_autofire <= cont_autofire+1;
          
      end
  wire 
       kbdjoyfire_processed = (joyconf[3] == 1'b0) ? kbdjoyfire : (autofire & kbdjoyfire);

  wire 
       db9joyfire_processed = (joyconf[7] == 1'b0) ? db9joyfire : (autofire & db9joyfire);

  
  always @* 
      begin
        oe_n = 1'b1;
        dout = 8'hZZ;
        kbdcol_out = kbdcol_in;
        if ((zxuno_regrd == 1'b1) && (zxuno_addr == JOYCONFADDR)) 
          begin
            oe_n = 1'b0;
            dout = joyconf;
          end
        else if ((rd_n == 1'b0) && 
                 ((iorq_n == 1'b0) && (a[7:0] == KEMPSTONADDR))) 
          begin
            dout = 8'h00;
            oe_n = 1'b0;
            if (joyconf[2:0] == KEMPSTON) 
              dout = {3'b000,kbdjoyfire_processed,kbdjoyup,kbdjoydown,kbdjoyleft,kbdjoyright} | dout;
              
            if (joyconf[6:4] == KEMPSTON) 
              dout = {3'b000,db9joyfire_processed,db9joyup,db9joydown,db9joyleft,db9joyright} | dout;
              
          end
        else if ((iorq_n == 1'b0) && 
                 ((a[7:0] == FULLERADDR) && (rd_n == 1'b0))) 
          begin
            dout = 8'hFF;
            oe_n = 1'b0;
            if (joyconf[2:0] == FULLER) 
              dout = dout & {~kbdjoyfire_processed,3'b111,~kbdjoyright,~kbdjoyleft,~kbdjoydown,~kbdjoyup};
              
            if (joyconf[6:4] == FULLER) 
              dout = {~db9joyfire_processed,3'b111,~db9joyright,~db9joyleft,~db9joydown,~db9joyup} & dout;
              
          end
        else if ((a[SINCLAIRP1ADDR] == 1'b0) && (rd_n == 1'b0) && 
                 ((iorq_n == 1'b0) && (a[0] == 1'b0))) 
          begin
            if (joyconf[2:0] == SINCLAIRP1) 
              kbdcol_out = {~kbdjoyleft,~kbdjoyright,~kbdjoydown,~kbdjoyup,~kbdjoyfire_processed} & kbdcol_out;
              
            if (joyconf[6:4] == SINCLAIRP1) 
              kbdcol_out = kbdcol_out & {~db9joyleft,~db9joyright,~db9joydown,~db9joyup,~db9joyfire_processed};
              
            if (joyconf[2:0] == CURSOR) 
              kbdcol_out = kbdcol_out & {~kbdjoydown,~kbdjoyup,~kbdjoyright,1'b1,~kbdjoyfire_processed};
              
            if (joyconf[6:4] == CURSOR) 
              kbdcol_out = kbdcol_out & {~db9joydown,~db9joyup,~db9joyright,1'b1,~db9joyfire_processed};
              
          end
        else if ((a[0] == 1'b0) && (a[SINCLAIRP2ADDR] == 1'b0) && 
                 ((rd_n == 1'b0) && (iorq_n == 1'b0))) 
          begin
            if (joyconf[2:0] == SINCLAIRP2) 
              kbdcol_out = kbdcol_out & {~kbdjoyfire_processed,~kbdjoyup,~kbdjoydown,~kbdjoyright,~kbdjoyleft};
              
            if (joyconf[6:4] == SINCLAIRP2) 
              kbdcol_out = {~db9joyfire_processed,~db9joyup,~db9joydown,~db9joyright,~db9joyleft} & kbdcol_out;
              
            if (joyconf[2:0] == CURSOR) kbdcol_out = {~kbdjoyleft,4'b1111} & kbdcol_out;
              
            if (joyconf[6:4] == CURSOR) kbdcol_out = {~db9joyleft,4'b1111} & kbdcol_out;
              
          end
          
      end
endmodule

