module registers( 
    input wire clk, 
    input wire rst, 
    input wire[4:0] readAddr1_i, 
    input wire readEnable1_i, 
    output reg[31:0] data1_o, 
    input wire[4:0] readAddr2_i, 
    input wire readEnable2_i, 
    output reg[31:0] data2_o, 
    input wire[4:0] writeAddr_i, 
    input wire[31:0] writeData_i, 
    input wire writeEnable_i 
    );
    reg[31:0] regs[0:31]; 
    always @(*) begin 
        if (readAddr1_i == 5'h0) begin 
            data1_o = `ZeroWord; 
        end else if (readEnable1_i == `Enable && writeEnable_i == `Enable && readAddr1_i == writeAddr_i) begin 
            data1_o = writeData_i; 
        end else if (readEnable1_i == `Enable) begin 
            data1_o = regs[readAddr1_i]; 
        end else begin 
            data1_o = `ZeroWord; 
        end
    end
    always @(*) begin 
        if (readAddr2_i == 5'h0) begin 
            data2_o = `ZeroWord; 
        end else if (readEnable2_i == `Enable && writeEnable_i == `Enable && readAddr2_i == writeAddr_i) begin 
            data2_o = writeData_i; 
        end else if (readEnable2_i == `Enable) begin 
            data2_o = regs[readAddr2_i]; 
        end else begin 
            data2_o = `ZeroWord; 
        end
    end
    always @(posedge clk) begin 
        if (rst == `Enable) begin 
            regs[0] <= `ZeroWord; 
            regs[31] <= `ZeroWord;
        end else if (writeEnable_i == `Enable && writeAddr_i != 5'h0) begin 
            regs[writeAddr_i] <= writeData_i; 
        end
    end
endmodule 