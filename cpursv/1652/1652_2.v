
module trif_oserdese1_vlog(T1,T2,T3,T4,load,C,CLKDIV,SR,TCE,DATA_RATE_TQ,TRISTATE_WIDTH,
                           INIT_TQ,SRVAL_TQ,data1,data2);

  input  T1,T2,T3,T4,load;
  input  C,CLKDIV,SR,TCE;
  input  [1:0] TRISTATE_WIDTH;
  input  [1:0] DATA_RATE_TQ;
  input  INIT_TQ,SRVAL_TQ;
  output data1,data2;
  wire DDR_CLK_EDGE;
  wire [3:0] INIT_TRANK1;
  wire [1:0] SRTYPE;

  assign SRTYPE = 2'b11;
  assign DDR_CLK_EDGE = 1'b1;
  assign INIT_TRANK1 = 4'b0000;
  reg  t1r,t2r,t3r,t4r;

  reg  qt1,qt2,qt2n;

  reg  data1,data2;

  reg  sdata_edge,odata_edge,ddr_data;

  wire C2p,C3;

  wire load;

  wire [6:0] tqsel;

  wire [4:0] sel;

  assign sel = {load,DATA_RATE_TQ,TRISTATE_WIDTH};
  parameter  ffd = 1;

  parameter  mxd = 1;

  tri0  GSR = glbl.GSR;

  
  always @(GSR)
      begin
        if (GSR) 
          begin
            assign t1r = INIT_TRANK1[0];
            assign t2r = INIT_TRANK1[1];
            assign t3r = INIT_TRANK1[2];
            assign t4r = INIT_TRANK1[3];
          end
        else 
          begin
            deassign t1r;
            deassign t2r;
            deassign t3r;
            deassign t4r;
          end
      end
  
  always @(posedge CLKDIV or posedge SR)
      begin
        begin
          if (!SRTYPE[1] & SR) 
            begin
              t1r <= #ffd 1'b0;
              t2r <= #ffd 1'b0;
              t3r <= #ffd 1'b0;
              t4r <= #ffd 1'b0;
            end
          else if (!SRTYPE[1]) 
            begin
              t1r <= #ffd T1;
              t2r <= #ffd T2;
              t3r <= #ffd T3;
              t4r <= #ffd T4;
            end
            
        end
      end
  
  always @(posedge CLKDIV)
      begin
        begin
          if (SRTYPE[1] & SR) 
            begin
              t1r <= #ffd 1'b0;
              t2r <= #ffd 1'b0;
              t3r <= #ffd 1'b0;
              t4r <= #ffd 1'b0;
            end
          else if (SRTYPE[1]) 
            begin
              t1r <= #ffd T1;
              t2r <= #ffd T2;
              t3r <= #ffd T3;
              t4r <= #ffd T4;
            end
            
        end
      end
  
  always @(sel or T1 or t1r or t3r)
      begin
        casex (sel)

          5'b00000: data1 <= #mxd T1;

          5'b10000: data1 <= #mxd T1;

          5'bX0000: data1 <= #mxd T1;

          5'b00100: data1 <= #mxd T1;

          5'b10100: data1 <= #mxd T1;

          5'bX0100: data1 <= #mxd T1;

          5'b01001: data1 <= #mxd T1;

          5'b11001: data1 <= #mxd T1;

          5'b01010: data1 <= #mxd t3r;

          5'b11010: data1 <= #mxd t1r;

          5'b01000:  ;

          5'b11000:  ;

          5'bX1000:  ;

          default: $display("DATA_RATE_TQ %b and/or TRISTATE_WIDTH %b at time %t are not supported by OSERDES",
                       DATA_RATE_TQ,TRISTATE_WIDTH,$time);

        endcase

      end
  
  always @(sel or T2 or t2r or t4r)
      begin
        casex (sel)

          5'b00000: data2 <= #mxd T2;

          5'b00100: data2 <= #mxd T2;

          5'b10000: data2 <= #mxd T2;

          5'b10100: data2 <= #mxd T2;

          5'bX0000: data2 <= #mxd T2;

          5'bX0100: data2 <= #mxd T2;

          5'b00X00: data2 <= #mxd T2;

          5'b10X00: data2 <= #mxd T2;

          5'bX0X00: data2 <= #mxd T2;

          5'b01001: data2 <= #mxd T2;

          5'b11001: data2 <= #mxd T2;

          5'bX1001: data2 <= #mxd T2;

          5'b01010: data2 <= #mxd t4r;

          5'b11010: data2 <= #mxd t2r;

          5'b01000:  ;

          5'b11000:  ;

          5'bX1000:  ;

          default: $display("DATA_RATE_TQ %b and/or TRISTATE_WIDTH %b at time %t are not supported by OSERDES",
                       DATA_RATE_TQ,TRISTATE_WIDTH,$time);

        endcase

      end
endmodule

