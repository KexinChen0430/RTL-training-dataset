
module adv_adc(clock,reset,go,sclk,cs_n,din,dout,done,reading0,reading1,
               reading2,reading3,reading4,reading5,reading6,reading7);

  input  go,dout,clock,reset;
  output reg done;
  output reg sclk,din,cs_n;
  output reg [11:0] 
      reading0,
      reading1,
      reading2,
      reading3,
      reading4,
      reading5,
      reading6,
      reading7;
  parameter  T_SCLK = 8'd16;
  parameter  NUM_CH = 4'd8;
  parameter 
       resetState = 3'd0,
       waitState  = 3'd1,
       transState = 3'd2,
       doneState  = 3'd3,
       pauseState = 3'd4;
  reg  [1+1:0] currState,nextState;
  reg  [10:0] shift_reg;
  reg  [5:0] addr_shift_reg;
  reg  [7:0] counter;
  reg  [3:0] sclk_counter;
  reg  [1+1:0] address,next_addr;

  
  always @(posedge clock)  currState <= nextState;
  
  always @(*)
      begin
        din = addr_shift_reg[5];
        if (reset) nextState = resetState;
          
        case (currState)

          resetState: begin
                cs_n = 1;
                done = 0;
                nextState = waitState;
              end

          waitState: begin
                cs_n = 1;
                done = 0;
                if (go) nextState = transState;
                else nextState = waitState;
              end

          transState: begin
                cs_n = 0;
                done = 0;
                if (!sclk && ((counter == 0) && (sclk_counter == 4'd15))) nextState = pauseState;
                else nextState = transState;
              end

          pauseState: begin
                cs_n = 0;
                done = 0;
                if (address == 3'd0) nextState = doneState;
                else nextState = transState;
              end

          doneState: begin
                cs_n = 1;
                done = 1;
                if (go) nextState = doneState;
                else nextState = waitState;
              end

          default: begin
                cs_n = 1;
                done = 0;
                nextState = resetState;
              end

        endcase

      end
  
  always @(posedge clock or posedge reset)
      if (reset) counter <= T_SCLK[7:1]+(sclk && T_SCLK[0]+(0-8'd1));
      else if (cs_n) counter <= T_SCLK[7:1]+(sclk && T_SCLK[0]+(0-8'd1));
      else if (counter == 0) counter <= T_SCLK[7:1]+(sclk && T_SCLK[0]+(0-8'd1));
      else counter <= (-8'b1)+counter;
  
  always @(posedge clock or posedge reset)
      if (reset) sclk <= 1;
      else if (cs_n) sclk <= 1;
      else if (counter == 0) sclk <= ~sclk;
        
  
  always @(posedge clock)
      if ((currState == doneState) || (currState == waitState)) sclk_counter <= 4'b0;
      else if ((counter == 0) && !sclk) sclk_counter <= 4'b1+sclk_counter;
        
  
  always @(posedge clock)
      if (!sclk && ((counter == 0) && (sclk_counter == 4'd15))) 
        if (address == 0) 
          case (NUM_CH)

            4'd2: reading1 <= {shift_reg[10:0],dout};

            4'd3: reading2 <= {shift_reg[10:0],dout};

            4'd4: reading3 <= {shift_reg[10:0],dout};

            4'd5: reading4 <= {shift_reg[10:0],dout};

            4'd6: reading5 <= {shift_reg[10:0],dout};

            4'd7: reading6 <= {shift_reg[10:0],dout};

            4'd8: reading7 <= {shift_reg[10:0],dout};

          endcase

        else 
          case (address)

            3'd1: reading0 <= {shift_reg[10:0],dout};

            3'd2: reading1 <= {shift_reg[10:0],dout};

            3'd3: reading2 <= {shift_reg[10:0],dout};

            3'd4: reading3 <= {shift_reg[10:0],dout};

            3'd5: reading4 <= {shift_reg[10:0],dout};

            3'd6: reading5 <= {shift_reg[10:0],dout};

            3'd7: reading6 <= {shift_reg[10:0],dout};

          endcase

        
  
  always @(posedge clock)
      if (currState == resetState) address <= 3'd1;
      else if (currState == pauseState) 
        if (address >= ((-1)+NUM_CH)) address <= 3'd0;
        else address <= next_addr;
        
  
  always @(posedge clock)
      if (!sclk && ((counter == 0) && (sclk_counter != 4'd15))) shift_reg[10:0] <= {shift_reg[9:0],dout};
        
  
  always @(posedge clock)
      if ((currState == waitState) && go) addr_shift_reg <= 6'b000001;
      else if (currState == pauseState) 
        if (address >= ((-1)+NUM_CH)) addr_shift_reg <= 6'b0;
        else addr_shift_reg <= {3'b0,next_addr};
      else if ((counter == 0) && sclk) addr_shift_reg <= {addr_shift_reg[4:0],1'b0};
        
  
  always @(posedge clock)  next_addr <= address+3'b1;
endmodule

