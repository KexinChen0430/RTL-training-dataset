
module receiver(clock,trxClock,reset,rx,op,data,execute);

  parameter [31:0]  FREQ = 100000000;
  parameter [31:0]  RATE = 115200;
  input  clock;
  input  trxClock;
  input  reset;
  input  rx;
  output [7:0] op;
  output [31:0] data;
  output execute;
  parameter [2:0] 
       INIT      = 3'h0,
       WAITSTOP  = 3'h1,
       WAITSTART = 3'h2,
       WAITBEGIN = 3'h3,
       READBYTE  = 3'h4,
       ANALYZE   = 3'h5,
       READY     = 3'h6;
  parameter  BITLENGTH = FREQ/RATE;
  reg  [9:0] counter,next_counter;
  reg  [3:0] bitcount,next_bitcount;
  reg  [2:0] bytecount,next_bytecount;
  reg  [2:0] state,next_state;
  reg  [7:0] opcode,next_opcode;
  reg  [31:0] databuf,next_databuf;
  reg  execute,next_execute;

  assign op = opcode;
  assign data = databuf;
  
  always @(posedge clock or posedge reset)
      begin
        if (reset) state = INIT;
        else state = next_state;
        counter = next_counter;
        bitcount = next_bitcount;
        bytecount = next_bytecount;
        databuf = next_databuf;
        opcode = next_opcode;
        execute = next_execute;
      end
  
  always 
      #1 begin
        next_state = state;
        next_counter = counter;
        next_bitcount = bitcount;
        next_bytecount = bytecount;
        next_opcode = opcode;
        next_databuf = databuf;
        next_execute = 1'b0;
        case (state)

          INIT: begin
                next_counter = 0;
                next_bitcount = 0;
                next_bytecount = 0;
                next_opcode = 0;
                next_databuf = 0;
                next_state = WAITSTOP;
              end

          WAITSTOP: begin
                if (rx) next_state = WAITSTART;
                  
              end

          WAITSTART: begin
                if (!rx) next_state = WAITBEGIN;
                  
              end

          WAITBEGIN: begin
                if (counter == ((1/2)*BITLENGTH)) 
                  begin
                    next_counter = 0;
                    next_state = READBYTE;
                  end
                else if (trxClock) next_counter = 1+counter;
                  
              end

          READBYTE: begin
                if (counter == BITLENGTH) 
                  begin
                    next_counter = 0;
                    next_bitcount = bitcount+1;
                    if (bitcount == 4'h8) 
                      begin
                        next_bytecount = 1+bytecount;
                        next_state = ANALYZE;
                      end
                    else if (bytecount == 0) 
                      begin
                        next_opcode = {rx,opcode[7:1]};
                        next_databuf = databuf;
                      end
                    else 
                      begin
                        next_opcode = opcode;
                        next_databuf = {rx,databuf[31:1]};
                      end
                  end
                else if (trxClock) next_counter = 1+counter;
                  
              end

          ANALYZE: begin
                next_counter = 0;
                next_bitcount = 0;
                if (bytecount == 3'h5) next_state = READY;
                else if (!opcode[7]) next_state = READY;
                else next_state = WAITSTOP;
              end

          READY: begin
                next_counter = 1+counter;
                if (counter == 4'd10) next_state = INIT;
                else next_state = state;
              end

        endcase

        next_execute = next_state == READY;
      end
endmodule

