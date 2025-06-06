module gpr_file(
    input   wire                        clock,
    input   wire                        reset,
    input   wire                        write_enable,
    input   wire[`REGS_ADDR_BUS]        write_addr,
    input   wire[`REGS_DATA_BUS]        write_data,
    input   wire                        read_enable1,
    input   wire[`REGS_ADDR_BUS]        read_addr1,
    output  reg[`REGS_DATA_BUS]         read_data1,
    input   wire                        read_enable2,
    input   wire[`REGS_ADDR_BUS]        read_addr2,
    output  reg[`REGS_DATA_BUS]         read_data2
);
    reg[`REGS_DATA_BUS]                 regs[0:`REGS_NUM - 1];
    always @ (posedge clock) begin
        if (reset == `DISABLE && write_enable == `ENABLE && write_addr != `REGS_NUM_LOG'h0) begin
            regs[write_addr] <= write_data;
        end
    end
    always @ (*) begin
        if (reset == `ENABLE) begin
            read_data1 <= 0; 
        end else if (read_addr1 == `REGS_NUM_LOG'h0) begin
            read_data1 <= 0; 
        end else if (write_enable == `ENABLE && read_enable1 == `ENABLE && read_addr1 == write_addr) begin
            read_data1 <= write_data;
        end else if (read_enable1 == `ENABLE) begin
            read_data1 <= regs[read_addr1];
        end else begin
            read_data1 <= 0; 
        end
    end
    always @ (*) begin
        if (reset == `ENABLE) begin
            read_data2 <= 0; 
        end else if (read_addr2 == `REGS_NUM_LOG'h0) begin
            read_data2 <= 0; 
        end else if (write_enable == `ENABLE && read_enable2 == `ENABLE && read_addr2 == write_addr) begin
            read_data2 <= write_data;
        end else if (read_enable2 == `ENABLE) begin
            read_data2 <= regs[read_addr2];
        end else begin
            read_data2 <= 0; 
        end
    end
endmodule