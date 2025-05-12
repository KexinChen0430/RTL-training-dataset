
module accumulator_memory(clk,reset,op,signal,read,write,load,full,index,preview,state);

  input  clk,reset,load;
  input  [1:0] op;
  input  [31:0] write;
  output [31:0] read;
  output [31:0] preview;
  output signal,full,state;
  output [9:0] index;
  reg  [31:0] M[0:1023];
  reg  [9:0] I;
  reg  [4:0] state;
  reg  signal;
  reg  [31:0] read;
  localparam  NOP = 2'b00, FETCH = 2'b01, SEND = 2'b10;
  localparam 
       INI   = 5'b00001,
       READ  = 5'b00010,
       WRITE = 5'b00100,
       READY = 5'b01000,
       DONE  = 5'b10000;

  assign preview = M[I];
  assign full = I == 10'b1111111111;
  assign index = I;
  reg  [8*5:1] state_string;

  
  always @(*)
      begin
        case (state)

          5'b00001: state_string = "INI  ";

          5'b00010: state_string = "READ ";

          5'b00100: state_string = WRITE;

          5'b01000: state_string = READY;

          5'b10000: state_string = "DONE ";

          default: state_string = "UNKN ";

        endcase

      end
  
  always @(posedge clk or posedge reset)
      begin
        if (reset) 
          begin
            state <= INI;
            I <= 0;
            signal <= 0;
          end
        else 
          begin
            case (state)

              INI: begin
                    if (load && (write != 0)) 
                      begin
                        M[I] <= write;
                        I <= 1+I;
                      end
                      
                    if ((op == FETCH) && !load) 
                      begin
                        state <= READ;
                      end
                      
                    if ((op == SEND) && !load) 
                      begin
                        state <= WRITE;
                      end
                      
                  end

              READ: begin
                    if ((I == 1023) && (M[I] == 0)) 
                      begin
                        read <= 0;
                        signal <= 1;
                        state <= READY;
                      end
                    else 
                      begin
                        if (M[I] != 0) 
                          begin
                            read <= M[I];
                            signal <= 1;
                            M[I] <= 0;
                            if (I != 1023) I <= 1+I;
                              
                            state <= READY;
                          end
                        else 
                          begin
                            I <= 1+I;
                          end
                      end
                  end

              WRITE: begin
                    if ((I == 1023) && (M[I] == 0)) 
                      begin
                        M[I] <= write;
                        signal <= 1;
                        I <= I-1;
                        state <= DONE;
                      end
                    else 
                      begin
                        if (M[I] == 0) 
                          begin
                            M[I] <= write;
                            signal <= 1;
                            state <= READY;
                          end
                        else 
                          begin
                            I <= I-1;
                          end
                      end
                  end

              READY: begin
                    signal <= 0;
                    read <= 'bx;
                    if ((signal == 0) && (op == FETCH)) 
                      begin
                        state <= READ;
                      end
                      
                    if ((signal == 0) && (op == SEND)) 
                      begin
                        state <= WRITE;
                      end
                      
                  end

              DONE: begin
                    signal <= 0;
                    read <= 'bx;
                    if ((signal == 0) && (op == FETCH)) 
                      begin
                        read <= 0;
                        signal <= 1;
                      end
                      
                    if ((signal == 0) && ((op == SEND) && (I == 1022))) 
                      begin
                        M[I] <= write;
                        signal <= 1;
                        I <= I-1;
                      end
                      
                    if ((op == SEND) && ((signal == 0) && (I == 1021))) 
                      begin
                        M[I] <= write;
                        signal <= 1;
                        I <= I-1;
                      end
                      
                    if ((signal == 0) && (op == SEND) && (I == 1020)) 
                      begin
                        M[I] <= write;
                        signal <= 1;
                        I <= I-1;
                      end
                      
                    if ((signal == 0) && (I == 1019)) 
                      begin
                        read <= ((M[1023]+M[1022])+M[1020])+M[1021];
                      end
                      
                  end

            endcase

          end
      end
endmodule

