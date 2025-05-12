
module GP_COUNT14(input  CLK,
                  input  wire RST,
                  output reg OUT);

  parameter  RESET_MODE = RISING;
  parameter  COUNT_TO = 14'h1;
  parameter  CLKIN_DIVIDE = 1;
  reg  [13:0]  count = COUNT_TO;

  
  initial  
  begin
    if (CLKIN_DIVIDE != 1) 
      begin
        $display("ERROR: CLKIN_DIVIDE values other than 1 not implemented");
        $finish;
      end
      
  end
  
  always @(*)
      begin
        OUT <= count == 14'h0;
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
                $display("Both-edge reset mode for GP_COUNT14 not implemented");
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
                $display("Invalid RESET_MODE on GP_COUNT14");
                $finish;
              end
            end

      endcase

  endgenerate

endmodule

