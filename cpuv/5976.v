module RegisterBanc(ReadData1, ReadData2, WriteData,ReadAddr1, ReadAddr2, WriteAddr, RegWrite, clk , ro); 
    output [31:0] ReadData1, ReadData2; 
    input [31:0] WriteData; 
    input [4:0] ReadAddr1, ReadAddr2, WriteAddr; 
    input [0:0] RegWrite, clk; 
	 output [31:0] ro; 
    reg [31:0] Register [0:31]; 
    initial begin 
      Register[0] = 32'd0;
      Register[31] = 32'd0;
    end
    always @ (posedge clk) begin 
        if (RegWrite) begin 
            Register[WriteAddr] <= WriteData; 
        end
    end
    assign ReadData1 = Register[ReadAddr1]; 
    assign ReadData2 = Register[ReadAddr2]; 
	 assign ro=Register[4'd2]; 
endmodule