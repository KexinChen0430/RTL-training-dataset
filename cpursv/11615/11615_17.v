
module spiRead(spiClock,start,bitIn,finish,byteOut,waitForBitIn);

  parameter  outByteSize = 1;
  input  spiClock;
  input  start;
  input  bitIn;
  output [(0-1)+(outByteSize*8):0] byteOut;
  output reg finish;
  input  waitForBitIn;
  wire _start;

  assign _start = start;
  reg   _running = 0, _waiting = 0;

  reg  [(0-1)+(outByteSize*8):0]  inputBuffer = 0;

  reg  [outByteSize+3:0] _i;

  assign byteOut = _running ? 'bZ : inputBuffer;
  reg   _error = 0;

  
  always @(posedge spiClock)
      begin
        if (_start && ~_running && ~_waiting) 
          begin
            if (~bitIn || ~waitForBitIn) 
              begin
                inputBuffer <= {{(0-1)+(outByteSize*8){1'b0}},bitIn};
                finish <= 0;
                _running <= 1;
                _i <= (0-1)+(outByteSize*8);
              end
              
          end
        else if (_start && (_running && ~_waiting)) 
          begin
            _i = _i-1;
            inputBuffer <= {inputBuffer[(0-(1+1))+(outByteSize*8):0],bitIn};
            if (_i == 0) 
              begin
                finish <= 1;
                _running <= 0;
                _waiting <= 1;
              end
              
          end
        else if (_start && _waiting) 
          begin

          end
        else if (~_start) 
          begin
            finish <= 0;
            _waiting <= 0;
          end
        else 
          begin
            _error = 1;
          end
      end
endmodule

