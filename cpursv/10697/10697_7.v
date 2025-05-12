
module mod(clk,rst,type,qp,i_valid,inverse,i_transize,Q,offset,shift);

  input  clk;
  input  rst;
  input  type;
  input  i_valid;
  input  inverse;
  input  [1:0] i_transize;
  input  [5:0] qp;
  output reg signed  [15:0] Q;
  output reg signed  [27:0] offset;
  output reg [4:0] shift;
  reg  [5:0] opi;
  reg  state;
  reg  next_state;
  reg  [1+1:0] q;
  reg  [3:0] p;
  parameter  DCT_4 = 2'b00;
  parameter  DCT_8 = 2'b01;
  parameter  DCT_16 = 2'b10;
  parameter  DCT_32 = 2'b11;
  parameter  IDLE = 1'b0;
  parameter  MOD = 1'b1;

  
  always @(*)
      if (!rst) next_state = IDLE;
      else 
        case (state)

          IDLE: if (i_valid) next_state = MOD;
              else next_state = IDLE;

          MOD: if (!i_valid && (opi < 3'd6)) 
                begin
                  next_state = IDLE;
                end
              else next_state = MOD;

        endcase

  
  always @(posedge clk or negedge rst)
      begin
        if (~rst) state <= IDLE;
        else state <= next_state;
      end
  
  always @(posedge clk or negedge rst)
      if (!rst) 
        begin
          q <= 3'd0;
          p <= 4'd0;
        end
      else if (i_valid && (state == IDLE)) 
        begin
          q <= 3'd0;
          p <= 4'd0;
          opi <= qp;
        end
      else if ((opi >= 6) && (state == MOD)) 
        begin
          opi <= opi+(-6);
          p <= p+1;
        end
      else if (!i_valid && (opi < 3'd6)) q <= opi[1+1:0];
        
  
  always @(posedge clk or negedge rst)
      if (!rst) 
        begin
          shift <= 5'b0;
          offset <= 28'b0;
        end
      else if (!inverse) 
        case (i_transize)

          DCT_4: begin
                shift <= p+19;
                offset <= type ? 9'd85<<(p+10) : 9'd171<<<(p+10);
              end

          DCT_8: begin
                shift <= p+18;
                offset <= type ? (9'd85*((1+1)**9))<<<p : ((9'd171*((1+1)**p))*((1+1)**9));
              end

          DCT_16: begin
                shift <= p+17;
                offset <= type ? 9'd85<<<(p+8) : (9'd171*((1+1)**p))<<8;
              end

          DCT_32: begin
                shift <= 16+p;
                offset <= type ? (((1+1)**7)<<<p*9'd85) : (((1+1)**(p+7))*9'd171);
              end

        endcase

      else 
        case (i_transize)

          DCT_4: begin
                shift <= 3'd1;
                offset <= 5'd1;
              end

          DCT_8: begin
                shift <= 3'd2;
                offset <= 5'd2;
              end

          DCT_16: begin
                shift <= 3'd3;
                offset <= 5'd4;
              end

          DCT_32: begin
                shift <= 3'd4;
                offset <= 5'd8;
              end

        endcase

  
  always @(*)
      if (!inverse) 
        case (q)

          3'd0: Q = 16'd26214;

          3'd1: Q = 16'd23302;

          3'd2: Q = 16'd20560;

          3'd3: Q = 16'd18396;

          3'd4: Q = 16'd16384;

          3'd5: Q = 16'd14564;

          default: Q = 16'd0;

        endcase

      else 
        case (q)

          3'd0: Q = 16'd40*((1+1)**p);

          3'd1: Q = 16'd45<<p;

          3'd2: Q = 16'd51*((1+1)**p);

          3'd3: Q = 16'd57*((1+1)**p);

          3'd4: Q = ((1+1)**p)*16'd64;

          3'd5: Q = 16'd72<<<p;

          default: Q = 16'd0;

        endcase

endmodule

