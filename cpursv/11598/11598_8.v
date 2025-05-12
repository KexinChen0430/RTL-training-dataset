
module fsm_ADC(input  clk,
               input  rst,
               input  rd,
               input  wr,
               input  [6:0] addr,
               input  [15:0] data_in,
               output reg [15:0] data_out,
               output reg valid,
               input  jtaglocked,
               input  busy,
               input  drdy,
               input  eoc,
               input  eos,
               input  [4:0] channel,
               input  [15:0] dout,
               output reg dwe,
               output reg den,
               output reg [6:0] daddr,
               output reg [15:0] din);

  parameter [1:0]  IDLE = 2'b00, WRITE = 2'b01, READ = 2'b10;
  reg  [1:0] state;

  
  initial  
  begin
    state <= IDLE;
    din <= 16'h0000;
    daddr <= 7'h00;
    den <= 1'b0;
    dwe <= 1'b0;
    valid <= 1'b0;
    data_out <= 16'h0000;
  end
  
  always @(posedge clk or posedge rst)
      begin
        if (rst) state <= IDLE;
        else 
          begin
            case (state)

              IDLE: begin
                    din <= 16'h0000;
                    daddr <= 7'h00;
                    den <= 1'b0;
                    dwe <= 1'b0;
                    valid <= 1'b0;
                    data_out <= 16'h0000;
                    if (!busy) 
                      begin
                        if (eos || eoc) 
                          begin
                            if (rd && !wr) 
                              begin
                                den <= 1'b1;
                                dwe <= 1'b0;
                                daddr <= 7'h03;
                                state <= READ;
                              end
                            else if (!rd && wr) 
                              begin
                                den <= 1'b1;
                                dwe <= 1'b1;
                                din <= data_in;
                                daddr <= addr;
                                state <= WRITE;
                              end
                              
                          end
                          
                      end
                      
                  end

              WRITE: begin
                    den <= 1'b0;
                    dwe <= 1'b0;
                    if (drdy) 
                      begin
                        valid <= 1'b1;
                        state <= IDLE;
                      end
                      
                  end

              READ: begin
                    den <= 1'b0;
                    dwe <= 1'b0;
                    if (drdy) 
                      begin
                        data_out <= dout;
                        valid <= 1'b1;
                        state <= IDLE;
                      end
                      
                  end

            endcase

          end
      end
endmodule

