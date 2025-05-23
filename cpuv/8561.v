module fifomem
    #(
        parameter  DATASIZE = 8,    
        parameter  ADDRSIZE = 4,    
        parameter  FALLTHROUGH = "TRUE" 
    ) (
        input  wire                wclk,      
        input  wire                wclken,    
        input  wire [ADDRSIZE-1:0] waddr,     
        input  wire [DATASIZE-1:0] wdata,     
        input  wire                wfull,     
        input  wire                rclk,      
        input  wire                rclken,    
        input  wire [ADDRSIZE-1:0] raddr,     
        output wire [DATASIZE-1:0] rdata      
    );
    localparam DEPTH = 1<<ADDRSIZE;
    reg [DATASIZE-1:0] mem [0:DEPTH-1];
    reg [DATASIZE-1:0] rdata_r;
    always @(posedge wclk) begin
        if (wclken && !wfull)
            mem[waddr] <= wdata; 
    end
    generate
        if (FALLTHROUGH == "TRUE")
        begin : fallthrough
            assign rdata = mem[raddr];
        end
        else
        begin : registered_read
            always @(posedge rclk) begin
                if (rclken)
                    rdata_r <= mem[raddr]; 
            end
            assign rdata = rdata_r;
        end
    endgenerate
endmodule 