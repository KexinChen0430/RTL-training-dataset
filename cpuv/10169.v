module. It 
output [5:0] ToSPieceOut; 
wire [5:0] ToSPieceOut; 
output [15:0] ToSMaskOut; 
wire [15:0] ToSMaskOut; 
input [5:0] PieceIn; 
input [15:0] MaskIn; 
input [15:0] MaskReset; 
input Enable; 
input PushPop; 
input Reset; 
input Clk; 
reg StackWrite; 
reg [2:0] WritePointer; 
reg [2:0] Pointer; 
reg [21:0] StackWriteData; 
wire [21:0] StackReadData; 
reg [2:0] NrItems; 
reg [5:0] ToSPiece; 
reg [15:0] ToSMask; 
reg [21:0] Stack [0:5-1]; 
always @(posedge Clk) begin: STACK_CONTROL
    if (Reset == 1) begin 
        StackWrite <= 0;
        WritePointer <= 0;
        StackWriteData <= 0;
        NrItems <= 0;
        ToSPiece <= 0;
        Pointer <= 0;
        ToSMask <= 65535;
    end
    else begin
        StackWrite <= 1'b0;
        if ((MaskReset != 0)) begin 
            ToSMask <= (ToSMask & (~MaskReset));
        end
        else if ((PushPop && Enable)) begin 
            ToSPiece <= PieceIn;
            ToSMask <= MaskIn;
            NrItems <= (NrItems + 1);
            if ((NrItems > 0)) begin
                StackWriteData <= {ToSPiece, ToSMask};
                StackWrite <= 1'b1;
                Pointer <= WritePointer;
                if ((WritePointer < (6 - 2))) begin
                    WritePointer <= (WritePointer + 1);
                end
            end
        end
        else if (((!PushPop) && Enable)) begin 
            ToSPiece <= StackReadData[22-1:16];
            ToSMask <= StackReadData[16-1:0];
            NrItems <= (NrItems - 1);
            WritePointer <= Pointer;
            if ((Pointer > 0)) begin
                Pointer <= (Pointer - 1);
            end
        end
    end
end
always @(posedge Clk) begin: STACK_WRITE_STACK
    if (StackWrite) begin 
        Stack[Pointer] <= StackWriteData;
    end
end
assign StackReadData = Stack[Pointer]; 
assign ToSPieceOut = ToSPiece; 
assign ToSMaskOut = ToSMask; 
endmodule 