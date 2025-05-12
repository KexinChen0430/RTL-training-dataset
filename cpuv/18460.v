module rs232(input  wire        clk,
             input  wire        rst,
             input  wire [3:0]  iKEY,
             input  wire [31:0] vsynccnt,
             input  wire `REQ   rs232_req,
             output wire `RES   rs232_res,
             input  wire        rs232in_attention,
             input  wire [7:0]  rs232in_data,
             input  wire        rs232out_busy,
             output wire        rs232out_w,
             output wire [7:0]  rs232out_d);
   parameter debug = 1;
   reg [31:0] tsc = 0;  
   reg [ 7:0] rs232in_cnt = 0;
   wire [31:0] addr = rs232_req`A;
   reg [31:0] rd_data = 0;
   assign     rs232_res`RD = rd_data;
   assign     rs232_res`HOLD = 0;
   reg [3:0]  iKEY_;
   always @(posedge clk)
     if (rst) begin
        rd_data     <= 0;
        tsc         <= 0;
        rs232in_cnt <= 0;
     end else begin
        iKEY_ <= iKEY;
        rd_data <= 0;
        tsc <= tsc + 1;
        if (rs232in_attention)
          rs232in_cnt <= rs232in_cnt + 1'h1;
        if (rs232_req`R) begin
           case (addr[4:2])
           0: rd_data <= {31'h0,rs232out_busy};
           1: rd_data <= {24'h0,rs232in_data}; 
           2: rd_data <= {24'h0,rs232in_cnt};  
           3: rd_data <= tsc;                  
           4: rd_data <= ~iKEY_;
           5: rd_data <= vsynccnt;
           endcase
        end
     end
   assign rs232out_d    = rs232_req`WD;
   assign rs232out_w    = rs232_req`W & addr[3:0] == 0;
endmodule