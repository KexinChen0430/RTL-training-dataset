
module GP_COUNT8(input  wire CLK,
                 input  wire RST,
                 output reg OUT,
                 output reg [7:0] POUT);

  parameter  RESET_MODE = RISING;
  parameter  COUNT_TO = 8'h1;
  parameter  CLKIN_DIVIDE = 1;

  
  initial  
  begin
    if (CLKIN_DIVIDE != 1) 
      begin
        $display("ERROR: CLKIN_DIVIDE values other than 1 not implemented");
        $finish;
      end
      
  end
  reg  [7:0]  count = COUNT_TO;

  
  always @(*)
      begin
        OUT <= count == 8'h0;
        POUT <= count;
      end
  
  generate
      case (RESET_MODE)

        RISING: begin
              
              always @(posedge CLK or posedge RST)
                  begin
                    if (RST) count <= 0;
                    else 
                      begin
                        count <= count+(0-1'd1);
                        if (count == 0) count <= COUNT_TO;
                          
                      end
                  end
            end

        FALLING: begin
              
              always @(posedge CLK or negedge RST)
                  begin
                    if (!RST) count <= 0;
                    else 
                      begin
                        count <= count+(0-1'd1);
                        if (count == 0) count <= COUNT_TO;
                          
                      end
                  end
            end

        BOTH: begin
              
              initial  
              begin
                $display("Both-edge reset mode for GP_COUNT8 not implemented");
                $finish;
              end
            end

        LEVEL: begin
              
              always @(posedge CLK or posedge RST)
                  begin
                    if (RST) count <= 0;
                    else 
                      begin
                        count <= count+(0-1'd1);
                        if (count == 0) count <= COUNT_TO;
                          
                      end
                  end
            end

        default: begin
              
              initial  
              begin
                $display("Invalid RESET_MODE on GP_COUNT8");
                $finish;
              end
            end

      endcase

  endgenerate

endmodule

