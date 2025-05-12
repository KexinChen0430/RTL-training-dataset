module fifo_cross_clocks
#(
  parameter integer DATA_WIDTH=16, 
  parameter integer DATA_DEPTH=4   
) (
    input                   rst,      
    input                   rrst,     
    input                   wrst,     
    input                   rclk,     
    input                   wclk,     
    input                   we,       
    input                   re,       
    input  [DATA_WIDTH-1:0] data_in,  
    output [DATA_WIDTH-1:0] data_out, 
    output                  nempty,   
    output                  half_empty 
);
    localparam integer DATA_2DEPTH=(1<<DATA_DEPTH)-1; 
    reg  [DATA_WIDTH-1:0]   ram [0:DATA_2DEPTH];     
    reg  [DATA_DEPTH-1:0] raddr;                     
    reg  [DATA_DEPTH-1:0] waddr;                     
    reg  [DATA_DEPTH-1:0] waddr_gray;                
    reg  [DATA_DEPTH-1:0] waddr_gray_rclk;           
    wire [DATA_DEPTH-1:0] waddr_plus1 = waddr + 1;   
    wire [DATA_DEPTH-1:0] waddr_plus1_gray = waddr_plus1 ^ {1'b0,waddr_plus1[DATA_DEPTH-1:1]}; 
    wire [DATA_DEPTH-1:0] raddr_gray = raddr ^ {1'b0,raddr[DATA_DEPTH-1:1]}; 
    wire [DATA_DEPTH-1:0] raddr_plus1 = raddr + 1;   
    wire [2:0] raddr_plus1_gray_top3 = raddr_plus1[DATA_DEPTH-1:DATA_DEPTH-3] ^ {1'b0,raddr_plus1[DATA_DEPTH-1:DATA_DEPTH-2]}; 
    reg  [2:0] raddr_gray_top3;                      
    reg  [2:0] raddr_gray_top3_wclk;                 
    wire [2:0] raddr_top3_wclk = {                   
        raddr_gray_top3_wclk[2],
        raddr_gray_top3_wclk[2]^raddr_gray_top3_wclk[1],
        raddr_gray_top3_wclk[2]^raddr_gray_top3_wclk[1]^raddr_gray_top3_wclk[0]};
    wire [2:0] waddr_top3=waddr[DATA_DEPTH-1:DATA_DEPTH-3]; 
    wire [2:0] addr_diff=waddr_top3[2:0]-raddr_top3_wclk[2:0]; 
    assign half_empty = ~addr_diff[2];
    assign nempty = (waddr_gray_rclk[3:0] ^ raddr_gray[3:0]) != 4'b0;
    assign data_out = ram[raddr];
    always @ (posedge wclk or posedge rst) begin
        if (rst)       waddr <= 0;
        else if (wrst) waddr <= 0;
        else if (we)   waddr <= waddr_plus1;
        if (rst)       waddr_gray <= 0;
        else if (wrst) waddr_gray <= 0;
        else if (we)   waddr_gray[3:0] <= waddr_plus1_gray[3:0];
    end
    always @ (posedge rclk or posedge rst) begin
        if (rst)       raddr <= waddr;
        else if (rrst) raddr <= waddr;
        else if (re)   raddr <= raddr_plus1;
        if (rst)       raddr_gray_top3 <= waddr[DATA_DEPTH-1 -: 3] ^ {1'b0,waddr[DATA_DEPTH-1 -: 2]};
        else if (rrst) raddr_gray_top3 <= waddr[DATA_DEPTH-1 -: 3] ^ {1'b0,waddr[DATA_DEPTH-1 -: 2]};
        else if (re)   raddr_gray_top3 <= raddr_plus1_gray_top3;
    end
    always @ (posedge rclk) begin
        waddr_gray_rclk[3:0] <= waddr_gray[3:0];
    end
    always @ (posedge wclk) begin
        raddr_gray_top3_wclk[2:0] <= raddr_gray_top3[2:0];
        if (we) ram[waddr] <= data_in; 
    end
endmodule