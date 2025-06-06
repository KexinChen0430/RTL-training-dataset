
module TailLight(input  reset,
                 input  left,
                 input  right,
                 input  clk,
                 output LC,
                 output LB,
                 output LA,
                 output RA,
                 output RB,
                 output RC);

  parameter  ST_IDLE = 3'b000;
  parameter  ST_L1 = 3'b001;
  parameter  ST_L2 = 3'b010;
  parameter  ST_L3 = 3'b011;
  parameter  ST_R1 = 3'b100;
  parameter  ST_R2 = 3'b101;
  parameter  ST_R3 = 3'b110;
  reg  [2:0] state,next_state;

  
  always @(posedge clk)
      if (reset) state <= ST_IDLE;
      else state <= next_state;
  
  always @* 
      begin
        case (state)

          ST_IDLE: begin
                if (~right && left) next_state = ST_L1;
                else if (right && ~left) next_state = ST_R1;
                else next_state = ST_IDLE;
              end

          ST_L1: next_state = ST_L2;

          ST_L2: next_state = ST_L3;

          ST_R1: next_state = ST_R2;

          ST_R2: next_state = ST_R3;

          default: next_state = ST_IDLE;

        endcase

        if (right && left) next_state = ST_IDLE;
          
      end
  assign LA = (state == ST_L3) || 
              ((state == ST_L1) || (state == ST_L2));
  assign LB = (state == ST_L3) || (state == ST_L2);
  assign LC = state == ST_L3;
  assign RA = (state == ST_R3) || (state == ST_R2) || (state == ST_R1);
  assign RB = (state == ST_R3) || (state == ST_R2);
  assign RC = state == ST_R3;
endmodule

