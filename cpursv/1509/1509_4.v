
module accumulator_processor(clk,reset,op,signal,read,write,req,grant,state);

  input  clk,reset,signal,grant;
  input  [1:0] op;
  input  [31:0] read;
  output [31:0] write;
  output req;
  output [6:0] state;
  reg   req = 0;
  reg  [6:0] state;
  reg  [1:0] op_internal;
  reg  [31:0] A;
  reg  [31:0] B;
  reg  [31:0] result;
  integer  slowdown = 0;
  integer  seed = 8882371;
  localparam  NOP = 2'b00, FETCH = 2'b01, SEND = 2'b10;
  localparam 
       REQ1 = 7'b0000001,
       RECA = 7'b0000010,
       REQ2 = 7'b0000100,
       RECB = 7'b0001000,
       ADD  = 7'b0010000,
       REQ3 = 7'b0100000,
       RSLT = 7'b1000000;

  assign op = ((op_internal == FETCH) || (op_internal == SEND)) ? op_internal : 2'bz;
  assign write = (state == RSLT) ? result : 32'bz;
  reg  [4*8:1] state_string;

  
  always @(*)
      begin
        case (state)

          7'b0000001: state_string = REQ1;

          7'b0000010: state_string = RECA;

          7'b0000100: state_string = REQ2;

          7'b0001000: state_string = RECB;

          7'b0010000: state_string = "ADD ";

          7'b0100000: state_string = REQ3;

          7'b1000000: state_string = RSLT;

          default: state_string = UNKN;

        endcase

      end
  
  always @(posedge clk or posedge reset)
      begin
        if (reset) 
          begin
            state <= REQ1;
            op_internal <= NOP;
          end
        else 
          begin
            case (state)

              REQ1: begin
                    req <= 1'b1;
                    if (!signal && grant) 
                      begin
                        state <= RECA;
                      end
                      
                  end

              RECA: begin
                    op_internal <= FETCH;
                    A <= read;
                    if (signal) 
                      begin
                        op_internal <= NOP;
                        req <= 1'b0;
                        state <= REQ2;
                      end
                      
                  end

              REQ2: begin
                    req <= 1'b1;
                    if (!signal && grant) 
                      begin
                        state <= RECB;
                      end
                      
                  end

              RECB: begin
                    op_internal <= FETCH;
                    B <= read;
                    if (signal) 
                      begin
                        op_internal <= NOP;
                        req <= 1'b0;
                        state <= ADD;
                        slowdown <= 1000+({$random(seed)}%9000);
                      end
                      
                  end

              ADD: begin
                    result <= A+B;
                    if (slowdown != 0) 
                      begin
                        slowdown <= slowdown+(0-1);
                      end
                    else 
                      begin
                        state <= REQ3;
                      end
                  end

              REQ3: begin
                    req <= 1'b1;
                    if (!signal && grant) 
                      begin
                        state <= RSLT;
                      end
                      
                  end

              RSLT: begin
                    op_internal <= SEND;
                    if (signal) 
                      begin
                        op_internal <= NOP;
                        req <= 1'b0;
                        state <= REQ1;
                      end
                      
                  end

            endcase

          end
      end
endmodule

