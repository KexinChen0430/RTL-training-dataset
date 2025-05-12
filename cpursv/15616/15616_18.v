
module MusicScore(ReadOrWrite,Address,KeyInput,KeyOutput,TimeInput,TimeOutput,
                  Clock,Reset,Choice);

  input  ReadOrWrite,Clock,Reset;
  parameter  DataLength = 4;
  input  [DataLength-1:0] KeyInput,TimeInput;
  output reg [DataLength-1:0] KeyOutput,TimeOutput;
  parameter  AddressBits = 5;
  input  [(-1)+AddressBits:0] Address;
  parameter  MemorySize = 40;
  input  [1:0] Choice;
  parameter  Music1 = 0;
  parameter  Music2 = 12;
  parameter  Music3 = 24;
  wire [3:0] MusicOffset;

  assign MusicOffset = Choice[1] ? Music3 : 
                       Choice[0] ? Music1 : Music2;
  reg  [DataLength-1:0] Keys[0:(-1)+MemorySize];

  reg  [DataLength-1:0] Times[0:(-1)+MemorySize];

  
  always @(posedge Clock or posedge Reset)
      if (Reset == 1) 
        begin

        end
      else if (ReadOrWrite == 1) 
        begin
          KeyOutput <= Keys[MusicOffset+Address];
          TimeOutput <= Times[MusicOffset+Address];
        end
      else 
        begin
          Keys[Address] <= KeyInput;
          Times[Address] <= TimeInput;
        end
endmodule

