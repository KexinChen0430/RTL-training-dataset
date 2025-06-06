
module mmu_table_load(input  wire iCLOCK,
                      input  wire inRESET,
                      input  wire iRESET_SYNC,
                      input  wire iLD_REQ,
                      input  wire [31:0] iLD_ADDR,
                      output wire oLD_BUSY,
                      output wire oMEM_REQ,
                      input  wire iMEM_LOCK,
                      output wire [31:0] oMEM_ADDR,
                      input  wire iMEM_VALID,
                      input  wire [63:0] iMEM_DATA,
                      output wire oDONE_VALID,
                      output wire [31:0] oDONE_DATA,
                      output wire [11:0] oDONE_FLAG0,
                      output wire [11:0] oDONE_FLAG1);

  reg  [1:0] b_main_state;
  reg  [31:0] b_req_addr;
  localparam  PL_MAIN_STT_IDLE = 2'h0;
  localparam  PL_MAIN_STT_REQ = 2'h1;
  localparam  PL_MAIN_STT_WAITING = 2'h2;
  wire 
       latch_condition = (b_main_state == PL_MAIN_STT_IDLE) && iLD_REQ;

  
  always @(posedge iCLOCK or negedge inRESET)
      begin
        if (!inRESET) 
          begin
            b_req_addr <= 32'h0;
          end
        else if (iRESET_SYNC) 
          begin
            b_req_addr <= 32'h0;
          end
        else 
          begin
            if (latch_condition) 
              begin
                b_req_addr <= iLD_ADDR;
              end
              
          end
      end
  
  always @(posedge iCLOCK or negedge inRESET)
      begin
        if (!inRESET) 
          begin
            b_main_state <= PL_MAIN_STT_IDLE;
          end
        else if (iRESET_SYNC) 
          begin
            b_main_state <= PL_MAIN_STT_IDLE;
          end
        else 
          begin
            case (b_main_state)

              PL_MAIN_STT_IDLE: begin
                    if (latch_condition) 
                      begin
                        if (iMEM_LOCK) 
                          begin
                            b_main_state <= PL_MAIN_STT_REQ;
                          end
                        else 
                          begin
                            b_main_state <= PL_MAIN_STT_WAITING;
                          end
                      end
                      
                  end

              PL_MAIN_STT_REQ: begin
                    if (!iMEM_LOCK) 
                      begin
                        b_main_state <= PL_MAIN_STT_WAITING;
                      end
                      
                  end

              PL_MAIN_STT_WAITING: begin
                    if (iMEM_VALID) 
                      begin
                        b_main_state <= PL_MAIN_STT_IDLE;
                      end
                      
                  end

              default: begin
                    b_main_state <= PL_MAIN_STT_IDLE;
                  end

            endcase

          end
      end
  assign oLD_BUSY = b_main_state != PL_MAIN_STT_IDLE;
  assign oMEM_REQ = (b_main_state == PL_MAIN_STT_REQ) || latch_condition;
  assign oMEM_ADDR = (b_main_state == PL_MAIN_STT_REQ) ? b_req_addr : iLD_ADDR;
  assign oDONE_VALID = (b_main_state == PL_MAIN_STT_WAITING) && iMEM_VALID;
  assign oDONE_DATA = b_req_addr[2] ? iMEM_DATA[63:32] : iMEM_DATA[31:0];
  assign oDONE_FLAG0 = iMEM_DATA[11:0];
  assign oDONE_FLAG1 = iMEM_DATA[43:32];
endmodule

