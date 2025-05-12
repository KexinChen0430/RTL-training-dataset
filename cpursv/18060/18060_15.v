
module l1_data_cache_counter(input  wire iCLOCK,
                             input  wire inRESET,
                             input  wire iCACHE_VALID,
                             input  wire iCACHE_HIT,
                             output wire [6:0] oINFO_COUNT);

  reg  [99:0] b_counter;

  
  always @(posedge iCLOCK or negedge inRESET)
      begin
        if (!inRESET) 
          begin
            b_counter <= 100'h0;
          end
        else 
          begin
            if (iCACHE_VALID) 
              begin
                b_counter <= {b_counter[98:0],iCACHE_HIT};
              end
              
          end
      end
  reg  [3:0] b_buffer0[0:9];

  reg  [5:0] b_buffer1[0:1];

  reg  [6:0] b_buffer2;

  
  always @(posedge iCLOCK or negedge inRESET)
      begin
        if (!inRESET) 
          begin
            b_buffer0[0] <= 4'h0;
            b_buffer2 <= 7'h0;
          end
        else 
          begin
            b_buffer0[0] <= ((b_counter[7]+b_counter[9])+(b_counter[4]+(((4'h0+b_counter[5])+(b_counter[1]+b_counter[0]))+b_counter[2])))+((b_counter[3]+b_counter[6])+b_counter[8]);
            b_buffer0[9] <= ((b_counter[99]+b_counter[98])+(((b_counter[91]+(b_counter[92]+b_counter[95]))+((b_counter[90]+4'h0)+b_counter[96]))+(b_counter[97]+b_counter[94])))+b_counter[93];
            b_buffer1[0] <= ((b_buffer0[0]+(6'h0+b_buffer0[2]))+b_buffer0[3])+(b_buffer0[4]+b_buffer0[1]);
            b_buffer1[1] <= (b_buffer0[5]+(6'h0+b_buffer0[8]))+((b_buffer0[9]+b_buffer0[6])+b_buffer0[7]);
            b_buffer2 <= b_buffer1[0]+b_buffer1[1];
          end
      end
  assign oINFO_COUNT = b_buffer2;
endmodule

