
module UART_Rx  #(parameter  N = 5, Full = 5'd29)
  (input  Reset,
   input  Clk,
   output reg [7:0] Data,
   output reg Ready,
   input  Ack,
   input  Rx);

  reg  tRx;
  reg  tAck;
  reg  [7:0] Temp;
  reg  [N-1:0] Count;
  reg  [1<<1:0] BitCount;
  reg  NewData;
  reg  [1:0] State;
  localparam  Idle = 2'b00;
  localparam  StartBit = 2'b01;
  localparam  Receiving = 2'b11;
  localparam  Done = 2'b10;
  reg  tReset;

  
  always @(posedge Clk)
      begin
        tRx <= Rx;
        tAck <= Ack;
        tReset <= Reset;
        if (tReset) 
          begin
            Data <= 0;
            Ready <= 0;
            NewData <= 0;
            Count <= 0;
            State <= Idle;
          end
        else 
          begin
            if (Ready & tAck) Ready <= 1'b0;
              
            case (State)

              Idle: begin
                    if (~tRx) 
                      begin
                        Count <= {1'b0,Full[N-1:1]};
                        State <= StartBit;
                      end
                      
                    if (~Ready && (~tAck & NewData)) 
                      begin
                        Data <= Temp;
                        Ready <= 1'b1;
                        NewData <= 1'b0;
                      end
                      
                  end

              Done: begin
                    if (tRx) State <= Idle;
                      
                  end

              default:  ;

            endcase

            if (~|Count) 
              begin
                case (State)

                  StartBit: begin
                        if (Rx) 
                          begin
                            State <= Idle;
                          end
                        else 
                          begin
                            BitCount <= 0;
                            Count <= Full;
                            State <= Receiving;
                          end
                      end

                  Receiving: begin
                        Temp <= {tRx,Temp[7:1]};
                        Count <= Full;
                        if (&BitCount) 
                          begin
                            NewData <= 1'b1;
                            State <= Done;
                          end
                          
                        BitCount <= 1'b1+BitCount;
                      end

                  default:  ;

                endcase

              end
            else 
              begin
                Count <= (0-1'b1)+Count;
              end
          end
      end
endmodule

