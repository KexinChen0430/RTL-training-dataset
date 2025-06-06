
module main_counter(input  wire iCLOCK,
                    input  wire inRESET,
                    input  wire iCONF_WRITE,
                    input  wire iCONF_ENA,
                    input  wire iCOUNT_WRITE,
                    input  wire [1:0] inCOUNT_DQM,
                    input  wire [63:0] iCOUNT_COUNTER,
                    output wire oWORKING,
                    output wire [63:0] oCOUNTER);

  reg  b_working;
  reg  [63:0] b_counter;

  
  always @(posedge iCLOCK or negedge inRESET)
      begin
        if (!inRESET) 
          begin
            b_working <= 1'b0;
            b_counter <= {64{1'b0}};
          end
        else 
          begin
            if (iCONF_WRITE) 
              begin
                b_working <= iCONF_ENA;
              end
              
            begin
              if (b_working) 
                begin
                  b_counter <= 64'h00000001+b_counter;
                end
              else 
                begin
                  if (iCOUNT_WRITE) 
                    begin
                      b_counter[31:0] <= !inCOUNT_DQM[0] ? iCOUNT_COUNTER[31:0] : b_counter[31:0];
                      b_counter[63:32] <= !inCOUNT_DQM[1] ? iCOUNT_COUNTER[63:32] : b_counter[63:32];
                    end
                    
                end
            end
          end
      end
  assign oCOUNTER = b_counter;
  assign oWORKING = b_working;
endmodule

