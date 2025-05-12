
module CAPB3O(PCLK,PRESETN,PENABLE,PSEL,PADDR,PWRITE,PWDATA,PRDATA,CAPB3I);

  parameter [5:0]  APB_DWIDTH = 32;
  parameter [5:0]  MADDR_BITS = 32;
  input  PCLK;
  input  PRESETN;
  input  PENABLE;
  input  PSEL;
  input  [31:0] PADDR;
  input  PWRITE;
  input  [31:0] PWDATA;
  output reg [31:0] PRDATA;
  output reg [31:0] CAPB3I;

  
  always @(posedge PCLK or negedge PRESETN)
      begin
        if (!PRESETN) 
          begin
            CAPB3I <= 32'b0;
          end
        else 
          begin
            if (PWRITE && PENABLE && PSEL) 
              begin
                if (APB_DWIDTH == 32) 
                  begin
                    if (PADDR[MADDR_BITS+(0-1):0] == {MADDR_BITS{1'b0}}) 
                      begin
                        CAPB3I <= PWDATA;
                      end
                      
                  end
                  
                if (APB_DWIDTH == 16) 
                  begin
                    if (PADDR[MADDR_BITS+(0-1):4] == {MADDR_BITS-4{1'b0}}) 
                      begin
                        case (PADDR[3:0])

                          4'b0000: CAPB3I[15:0] <= PWDATA[15:0];

                          4'b0100: CAPB3I[31:16] <= PWDATA[15:0];

                          4'b1000: CAPB3I <= CAPB3I;

                          4'b1100: CAPB3I <= CAPB3I;

                        endcase

                      end
                      
                  end
                  
                if (APB_DWIDTH == 8) 
                  begin
                    if (PADDR[MADDR_BITS+(0-1):4] == {MADDR_BITS-4{1'b0}}) 
                      begin
                        case (PADDR[3:0])

                          4'b0000: CAPB3I[7:0] <= PWDATA[7:0];

                          4'b0100: CAPB3I[15:8] <= PWDATA[7:0];

                          4'b1000: CAPB3I[23:16] <= PWDATA[7:0];

                          4'b1100: CAPB3I[31:24] <= PWDATA[7:0];

                        endcase

                      end
                      
                  end
                  
              end
              
          end
      end
  
  always @(*)
      begin
        PRDATA = 32'b0;
        if (APB_DWIDTH == 32) 
          begin
            if (PADDR[MADDR_BITS+(0-1):0] == {MADDR_BITS{1'b0}}) 
              begin
                PRDATA = CAPB3I;
              end
              
          end
          
        if (APB_DWIDTH == 16) 
          begin
            if (PADDR[MADDR_BITS+(0-1):4] == {MADDR_BITS-4{1'b0}}) 
              begin
                case (PADDR[3:0])

                  4'b0000: PRDATA[15:0] = CAPB3I[15:0];

                  4'b0100: PRDATA[15:0] = CAPB3I[31:16];

                  4'b1000: PRDATA = 32'b0;

                  4'b1100: PRDATA = 32'b0;

                endcase

              end
              
          end
          
        if (APB_DWIDTH == 8) 
          begin
            if (PADDR[MADDR_BITS+(0-1):4] == {MADDR_BITS-4{1'b0}}) 
              begin
                case (PADDR[3:0])

                  4'b0000: PRDATA[7:0] = CAPB3I[7:0];

                  4'b0100: PRDATA[7:0] = CAPB3I[15:8];

                  4'b1000: PRDATA[7:0] = CAPB3I[23:16];

                  4'b1100: PRDATA[7:0] = CAPB3I[31:24];

                endcase

              end
              
          end
          
      end
endmodule

