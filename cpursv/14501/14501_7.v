
module DALU(clk,rst,in_valid,instruction,out_valid,out);

  input  clk;
  input  rst;
  input  in_valid;
  input  [18:0] instruction;
  output reg out_valid;
  output reg signed  [15:0] out;
  parameter  IDLE = 0, INPUT = 1, OUTPUT = 1<<<1, OP = 3;
  reg  [1:0] cState,nState;
  wire [1<<<1:0] L;
  wire signed  [5:0] s,t;
  wire signed  [3:0] l;
  wire signed  [9:0] i;

  assign L = instruction[18:16];
  assign s = instruction[15:10];
  assign t = instruction[9:4];
  assign l = instruction[3:0];
  assign i = instruction[9:0];
  
  always @(posedge clk or posedge rst)
      begin
        if (rst) cState <= IDLE;
        else cState <= nState;
      end
  
  always @(*)
      begin
        case (cState)

          IDLE: if (in_valid) nState = INPUT;
                

          INPUT: if (!in_valid) nState = OUTPUT;
                

          OUTPUT: nState = IDLE;

          default: nState = IDLE;

        endcase

      end
  
  always @(posedge clk or posedge rst)
      begin
        if (rst) out_valid <= 0;
        else 
          begin
            case (cState)

              IDLE: out_valid <= 0;

              INPUT: out_valid <= 0;

              OUTPUT: out_valid <= 1;

              default: out_valid <= out_valid;

            endcase

          end
      end
  
  always @(posedge clk or posedge rst)
      begin
        if (rst) out <= 0;
        else 
          begin
            case (cState)

              IDLE: begin
                    if (nState == INPUT) 
                      begin
                        case (L)

                          0: begin
                                case (l)

                                  0: out <= t & s;

                                  1: out <= (~s & t) | s;

                                  1<<<1: out <= s ^ t;

                                  3: out <= s+t;

                                  4: out <= (-t)+s;

                                  default: out <= out;

                                endcase

                              end

                          1: out <= t*(l*s);

                          1<<<1: out <= ((l+t)+s)**1<<<1;

                          3: out <= i+s;

                          4: out <= (0-i)+s;

                          default: out <= out;

                        endcase

                      end
                      
                  end

              INPUT: out <= out;

              OUTPUT: out <= out;

              default: out <= out;

            endcase

          end
      end
endmodule

