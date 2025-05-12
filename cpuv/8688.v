module ARM_ALU(input wire [31:0] A,B,input wire[4:0] OP,input wire [3:0] FLAGS,output wire [31:0] Out,output wire [3:0] FLAGS_OUT, input wire S,ALU_OUT);
parameter HIGHZ = 32'hzzzzzzzz;
reg [31:0] buffer,_A,_B;
reg [3:0] FLAGS_buff;
initial begin
	FLAGS_buff=4'h0;
	buffer = 0;
end
always @(A or B or OP)
begin
_A=A;
_B=B;
casez(OP)
  5'b00000,5'b01000:
	begin
		buffer =  _A & _B ;
	end
  5'b00001,5'b01001:
  begin
		buffer = _A ^ _B ;
  end
  5'b00010,5'b01010:
	begin
		_B = ~B+1;
		{FLAGS_buff[1],buffer} = _A + _B ;
	end
  5'b00011:
	begin
		_A = ~_A+1;
		{FLAGS_buff[1],buffer} = _B + _A;
	end
  5'b00100,5'b01011:
	  begin
		FLAGS_buff=FLAGS;
		{FLAGS_buff[1],buffer} = _A + _B ;
	  end
  5'b00101:
  begin
		FLAGS_buff=FLAGS;
		{FLAGS_buff[1],buffer} = _A + _B + FLAGS[1];
  end
  5'b00110:
	begin
		_B = ~B+1;
		{FLAGS_buff[1],buffer} = _A + _B - !FLAGS[1];
	end
  5'b00111:
	begin
		_A = ~A+1;
		{FLAGS_buff[1],buffer} = _B + _A - !FLAGS[1];
	end
  5'b01100:
  begin
		buffer = _A | _B;
  end
  5'b01110:
	begin
		buffer = _A & ~_B;end
  5'b01111:
    begin
		buffer = ~ _B;
	end
  5'b10000:buffer = B;
  5'b10001:buffer = A + 4;
  5'b10010,5'b01101:buffer = A;
endcase
end
assign FLAGS_OUT =  S ? FLAGS_buff : FLAGS;
assign Out =  ALU_OUT ?  buffer : HIGHZ;
always@(posedge ALU_OUT)begin
		if(OP<5'b10000)begin
			#1 FLAGS_buff[3] = buffer[31];
			FLAGS_buff[2] = buffer[31:0] === 0;
			FLAGS_buff[0] = _A[31] == _B[31] && _A[31] != buffer[31];
		end
end
endmodule