
module nukv_HT_Read_v2  #(parameter 
       KEY_WIDTH      = 128,
       META_WIDTH     = 96,
       HASHADDR_WIDTH = 64,
       MEMADDR_WIDTH  = 21)
  (input  wire clk,
   input  wire rst,
   input  wire [HASHADDR_WIDTH+(KEY_WIDTH+((-1)+META_WIDTH)):0] input_data,
   input  wire input_valid,
   output wire input_ready,
   input  wire [HASHADDR_WIDTH+(KEY_WIDTH+((-1)+META_WIDTH)):0] feedback_data,
   input  wire feedback_valid,
   output wire feedback_ready,
   output reg [HASHADDR_WIDTH+(KEY_WIDTH+((-1)+META_WIDTH)):0] output_data,
   output reg output_valid,
   input  wire output_ready,
   output reg [31:0] rdcmd_data,
   output reg rdcmd_valid,
   input  wire rdcmd_ready);

  reg  selectInputNext;
  reg  selectInput;
  localparam [2:0] 
       ST_IDLE           = 0,
       ST_ISSUE_READ_ONE = 1,
       ST_ISSUE_READ_TWO = 2,
       ST_OUTPUT_KEY     = 3;
  reg  [2:0] state;
  wire [HASHADDR_WIDTH+(KEY_WIDTH+((-1)+META_WIDTH)):0] in_data;
  wire in_valid;
  reg  in_ready;
  wire [HASHADDR_WIDTH+(-1):0] hash_data;

  assign in_data = (selectInput == 1) ? input_data : feedback_data;
  assign in_valid = (selectInput == 1) ? input_valid : feedback_valid;
  assign input_ready = (selectInput == 1) ? in_ready : 0;
  assign feedback_ready = (selectInput == 1) ? 0 : in_ready;
  assign hash_data = (selectInput == 1) ? input_data[HASHADDR_WIDTH+(KEY_WIDTH+((-1)+META_WIDTH)):META_WIDTH+KEY_WIDTH] : feedback_data[HASHADDR_WIDTH+(KEY_WIDTH+((-1)+META_WIDTH)):META_WIDTH+KEY_WIDTH];
  wire [MEMADDR_WIDTH-1:0] addr1;

  wire [MEMADDR_WIDTH-1:0] addr2;

  assign addr1 = hash_data[0 +: HASHADDR_WIDTH*(1/2)];
  assign addr2 = hash_data[HASHADDR_WIDTH*(1/2) +: HASHADDR_WIDTH*(1/2)];
  
  always @(posedge clk)
      begin
        if (rst) 
          begin
            selectInput <= 1;
            selectInputNext <= 0;
            state <= ST_IDLE;
            in_ready <= 0;
            rdcmd_valid <= 0;
            output_valid <= 0;
          end
        else 
          begin
            if ((rdcmd_valid == 1) && (rdcmd_ready == 1)) 
              begin
                rdcmd_valid <= 0;
              end
              
            if ((output_ready == 1) && (output_valid == 1)) 
              begin
                output_valid <= 0;
              end
              
            in_ready <= 0;
            case (state)

              ST_IDLE: begin
                    if ((rdcmd_ready == 1) && (output_ready == 1)) 
                      begin
                        selectInput <= selectInputNext;
                        selectInputNext <= ~selectInputNext;
                        if ((feedback_valid == 1) && 
                            ((input_valid == 0) && (selectInputNext == 1))) 
                          begin
                            selectInput <= 0;
                            selectInputNext <= 1;
                          end
                          
                        if ((input_valid == 1) && (selectInputNext == 0) && 
                            (feedback_valid == 0)) 
                          begin
                            selectInput <= 1;
                            selectInputNext <= 0;
                          end
                          
                        if ((selectInput == 1) && (input_valid == 1)) 
                          begin
                            state <= ST_ISSUE_READ_ONE;
                          end
                          
                        if ((selectInput == 0) && (feedback_valid == 1)) 
                          begin
                            state <= ST_ISSUE_READ_ONE;
                          end
                          
                      end
                      
                  end

              ST_ISSUE_READ_ONE: begin
                    state <= ST_ISSUE_READ_TWO;
                    output_data <= in_data;
                    rdcmd_data[MEMADDR_WIDTH-1:0] <= addr1[MEMADDR_WIDTH-1:0];
                    rdcmd_valid <= 1;
                    rdcmd_data[31:MEMADDR_WIDTH] <= 0;
                  end

              ST_ISSUE_READ_TWO: begin
                    if (rdcmd_ready == 1) 
                      begin
                        state <= ST_OUTPUT_KEY;
                        in_ready <= 1;
                        rdcmd_data[MEMADDR_WIDTH-1:0] <= addr2[MEMADDR_WIDTH-1:0];
                        rdcmd_valid <= 1;
                        rdcmd_data[31:MEMADDR_WIDTH] <= 0;
                      end
                      
                  end

              ST_OUTPUT_KEY: begin
                    if (output_ready == 1) 
                      begin
                        output_valid <= 1;
                        state <= ST_IDLE;
                      end
                      
                  end

            endcase

          end
      end
endmodule

