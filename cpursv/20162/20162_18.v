
module HaarFilter  #(parameter 
       STAGES         = 4,
       INTERNAL_WIDTH = 18,
       IN_WIDTH       = 16,
       OUT_WIDTH      = 16)
  (input  clk,
   input  rst,
   input  en,
   input  signed  [IN_WIDTH+(0-1):0] dataIn,
   output reg [STAGES:0] outStrobes,
   output reg [((1+STAGES)*OUT_WIDTH)+(0-1):0] dataOut);

  
  initial  
  begin
    if ((STAGES > 8) || (STAGES < (1+1))) 
      begin
        $display("Attribute STAGES on HaarFilter instance %m is set to %d. Valid range is 2 to 8",
                 STAGES);
        #1 $finish;
      end
      
    if (INTERNAL_WIDTH < (1+1)) 
      begin
        $display("Attribute INTERNAL_WIDTH on HaarFilter instance %m is set to %d. Must be at least 2.",
                 INTERNAL_WIDTH);
        #1 $finish;
      end
      
    if (IN_WIDTH < (1+1)) 
      begin
        $display("Attribute IN_WIDTH on HaarFilter instance %m is set to %d. Must be at least 2.",
                 IN_WIDTH);
        #1 $finish;
      end
      
    if (OUT_WIDTH < (1+1)) 
      begin
        $display("Attribute OUT_WIDTH on HaarFilter instance %m is set to %d. Must be at least 2.",
                 OUT_WIDTH);
        #1 $finish;
      end
      
  end
  reg  signed  [(0-1)+INTERNAL_WIDTH:0] lowPass[STAGES-1:0];

  reg  signed  [(0-1)+INTERNAL_WIDTH:0] prevArray[STAGES-1:0];

  reg  signed  [(0-1)+INTERNAL_WIDTH:0] highPass[STAGES-1:0];

  reg  [7:0] counter;

  integer outArray;

  integer i;

  wire signed  [INTERNAL_WIDTH:0] calcOut;

  wire signed  [(0-1)+INTERNAL_WIDTH:0] in0;

  wire signed  [(0-1)+INTERNAL_WIDTH:0] in1;

  reg  signed  [IN_WIDTH+(0-1):0] dataInD1;

  reg  [3:0] index;

  reg  [3:0] index2;

  reg  enD1;

  wire step0;

  wire step1;

  
  always @(counter)
      begin
        if (counter[0] == 1'b0) index = 'd0;
        else if (counter[1:0] == 2'b01) index = 'd1;
        else if (counter[1+1:0] == 3'b011) index = 'd2;
        else if (counter[3:0] == 4'b0111) index = 'd3;
        else if (counter[4:0] == 5'b01111) index = 'd4;
        else if (counter[5:0] == 6'b011111) index = 'd5;
        else if (counter[6:0] == 7'b0111111) index = 'd6;
        else if (counter[7:0] == 8'b01111111) index = 'd7;
        else index = 'd8;
        if (counter[0] == 1'b0) index2 = 'd8;
        else if (counter[1:0] == 2'b01) index2 = 'd0;
        else if (counter[1+1:0] == 3'b011) index2 = 'd1;
        else if (counter[3:0] == 4'b0111) index2 = 'd2;
        else if (counter[4:0] == 5'b01111) index2 = 'd3;
        else if (counter[5:0] == 6'b011111) index2 = 'd4;
        else if (counter[6:0] == 7'b0111111) index2 = 'd5;
        else if (counter[7:0] == 8'b01111111) index2 = 'd6;
        else index2 = 'd7;
      end
  if (IN_WIDTH > INTERNAL_WIDTH) 
    begin
      assign in0 = counter[0] ? prevArray[index2] : dataInD1>>>(IN_WIDTH+(0-INTERNAL_WIDTH));
      assign in1 = counter[0] ? lowPass[index2] : dataIn>>>(IN_WIDTH+(0-INTERNAL_WIDTH));
    end
  else 
    begin
      assign in0 = counter[0] ? prevArray[index2] : (dataInD1*1<<INTERNAL_WIDTH<<(-IN_WIDTH));
      assign in1 = counter[0] ? lowPass[index2] : ((1<<INTERNAL_WIDTH*dataIn)*1<<(-IN_WIDTH));
    end
  assign step0 = en && !enD1;
  assign step1 = !en && enD1;
  assign calcOut = step1 ? (in1+(-in0)) : (in0+in1);
  
  always @(posedge clk)
      begin
        if (rst) 
          begin
            counter <= 'd0;
            enD1 <= 'd0;
            outStrobes <= 'd0;
            dataInD1 <= 'd0;
            for (i = 0; i < STAGES; i = i+1)
                begin
                  lowPass[i] <= 'd0;
                  highPass[i] <= 'd0;
                  prevArray[i] <= 'd0;
                end
          end
        else 
          begin
            enD1 <= en;
            if (step1) 
              begin
                counter <= 2'd1+counter;
              end
              
            if (step1) dataInD1 <= dataIn;
              
            for (i = 0; i < STAGES; i = i+1)
                begin
                  if ((index == i) && step1) 
                    begin
                      highPass[i] <= calcOut[INTERNAL_WIDTH:1];
                      outStrobes[STAGES+(-i)] <= 1'b1;
                    end
                  else 
                    begin
                      outStrobes[STAGES+(-i)] <= 1'b0;
                    end
                  if ((index == i) && step0) 
                    begin
                      lowPass[i] <= calcOut[INTERNAL_WIDTH:1];
                      prevArray[i] <= lowPass[i];
                    end
                    
                end
            if ((index == (STAGES-1)) && step0) 
              begin
                outStrobes[0] <= 1'b1;
              end
            else 
              begin
                outStrobes[0] <= 1'b0;
              end
          end
      end
  if (INTERNAL_WIDTH > OUT_WIDTH) 
    begin
      
      always @(*)
          begin
            dataOut[0 +: OUT_WIDTH] = lowPass[STAGES-1]>>>INTERNAL_WIDTH-OUT_WIDTH;
            for (outArray = 0; outArray < STAGES; outArray = 1+outArray)
                begin
                  dataOut[(1+outArray)*OUT_WIDTH +: OUT_WIDTH] = highPass[(STAGES-1)+(0-outArray)]>>>INTERNAL_WIDTH-OUT_WIDTH;
                end
          end
    end
  else 
    begin
      
      always @(*)
          begin
            dataOut[0 +: OUT_WIDTH] = lowPass[STAGES-1]<<OUT_WIDTH*1<<(0-INTERNAL_WIDTH);
            for (outArray = 0; outArray < STAGES; outArray = 1+outArray)
                begin
                  dataOut[(1+outArray)*OUT_WIDTH +: OUT_WIDTH] = highPass[(STAGES-1)+(0-outArray)]<<<OUT_WIDTH<<<0-INTERNAL_WIDTH;
                end
          end
    end
endmodule

