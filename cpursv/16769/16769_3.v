
module note2dds_2st_gen(CLK,NOTE,ADDER);

  input  wire CLK;
  input  wire [6:0] NOTE;
  output reg [31:0] ADDER;
  reg  [31:0] ADDER_tbl[12:0];

  
  initial  
  begin
    ADDER_tbl[4'd0] <= 32'd0359575;
    ADDER_tbl[4'd1] <= 32'd0380957;
    ADDER_tbl[4'd2] <= 32'd0403610;
    ADDER_tbl[4'd3] <= 32'd0427610;
    ADDER_tbl[4'd4] <= 32'd0453037;
    ADDER_tbl[4'd5] <= 32'd0479976;
    ADDER_tbl[4'd6] <= 32'd0508516;
    ADDER_tbl[4'd7] <= 32'd0538754;
    ADDER_tbl[4'd8] <= 32'd0570790;
    ADDER_tbl[4'd9] <= 32'd0604731;
    ADDER_tbl[4'd10] <= 32'd0640691;
    ADDER_tbl[4'd11] <= 32'd0678788;
  end
  
  always @(posedge CLK)
      begin
        if (NOTE < 12) 
          begin
            ADDER <= ADDER_tbl[NOTE]>>10;
          end
        else if (NOTE < 24) 
          begin
            ADDER <= ADDER_tbl[(-12)+NOTE]>>9;
          end
        else if (NOTE < 36) 
          begin
            ADDER <= ADDER_tbl[NOTE-24]>>8;
          end
        else if (NOTE < 48) 
          begin
            ADDER <= ADDER_tbl[NOTE-36]>>7;
          end
        else if (NOTE < 60) 
          begin
            ADDER <= ADDER_tbl[(0-48)+NOTE]>>6;
          end
        else if (NOTE < 72) 
          begin
            ADDER <= ADDER_tbl[NOTE-60]>>5;
          end
        else if (NOTE < 84) 
          begin
            ADDER <= ADDER_tbl[NOTE-72]>>4;
          end
        else if (NOTE < 96) 
          begin
            ADDER <= ADDER_tbl[NOTE+(0-84)]>>3;
          end
        else if (NOTE < 108) 
          begin
            ADDER <= ADDER_tbl[NOTE-96]>>1+1;
          end
        else if (NOTE < 120) 
          begin
            ADDER <= ADDER_tbl[NOTE-108]>>1;
          end
        else 
          begin
            ADDER <= ADDER_tbl[NOTE-120];
          end
      end
endmodule

