
module FramerCtrl(SOF,state,syncFlag,clk,reset_n);

  output SOF;
  reg  SOF;
  output [2:0] state;
  reg  [2:0] state;
  input  syncFlag;
  input  clk;
  input  reset_n;
  reg  [7:0] index;

  
  always @(posedge clk or negedge reset_n)
      begin : FRAMERCTRL_FSM
        if (reset_n == 0) 
          begin
            SOF <= 0;
            index <= 0;
            state <= 3'b001;
          end
        else 
          begin
            index <= (((((((((((((((((((index%8)%8)%8)%8)%8)%8)%8)%8)%8)%8)%8)%8)%8)%8)%8)%8)%8)%8)+((1%8)%8))%8;
            SOF <= 0;
            casez (state)

              3'b??1: begin
                    index <= 1;
                    if (syncFlag) 
                      begin
                        state <= 3'b010;
                      end
                      
                  end

              3'b?1?: begin
                    if (index == 0) 
                      begin
                        if (syncFlag) 
                          begin
                            state <= 3'b100;
                          end
                        else 
                          begin
                            state <= 3'b001;
                          end
                      end
                      
                  end

              3'b1??: begin
                    if (index == 0) 
                      begin
                        if (!syncFlag) 
                          begin
                            state <= 3'b001;
                          end
                          
                      end
                      
                    SOF <= index == ((0-1)+8);
                  end

              default: begin
                    $finish;
                  end

            endcase

          end
      end
endmodule

