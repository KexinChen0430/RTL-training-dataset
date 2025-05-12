module RegisterFile(
    output [31:0] Read1,      
    output [31:0] Read2,      
    input [31:0] Writedata,   
    input [4:0] Raddr1,       
    input [4:0] Raddr2,       
    input [4:0] Waddr,        
    input RegWr,              
    input CLK,                
    input RESET               
);
    reg [31:0] registers [0:31];
    always @(posedge RESET) begin
        integer i;
        for (i = 0; i < 32; i = i + 1) begin
            registers[i] = 0;
        end
    end
    assign Read1 = registers[Raddr1];
    assign Read2 = registers[Raddr2];
    always @(negedge CLK) begin
        if (RegWr) begin
            registers[Waddr] = Writedata;
            $display("Reg %d current %d new %d", Waddr, registers[Waddr], Writedata);
        end
    end
    always @(RegWr or Writedata) begin
        $display("----------------------------------------------");
        $display("time %0d\t", $time);
        $display("Reg10 %d", registers[10]);
        $display("Reg11 %d", registers[11]);
        $display("Reg12 %d", registers[12]);
        $display("Reg13 %d", registers[13]);
        $display("Reg14 %d", registers[14]);
        $display("Reg15 %d", registers[15]);
        $display("Reg16 %d", registers[16]);
    end
endmodule